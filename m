From: bp@alien8.de (Borislav Petkov)
Date: Fri, 9 May 2014 22:52:18 +0200
Subject: [PATCHv3 3/3] edac: altera: Add EDAC support for Altera SDRAM
In-Reply-To: <CAF03EBeKbXr-7+qeARkBRXjystMjs4yEWnmw7q8tgJv9-SPgXA@mail.gmail.com>
References: <1399330337-16748-1-git-send-email-tthayer@altera.com>
 <1399330337-16748-4-git-send-email-tthayer@altera.com>
 <20140508120524.GF12548@pd.tnic>
 <CAF03EBecxtMr1670ktQKTAZX_kHeZWz1SwuEk373B99BoVjbDw@mail.gmail.com>
 <20140509135259.GC16260@pd.tnic>
 <CAF03EBeKbXr-7+qeARkBRXjystMjs4yEWnmw7q8tgJv9-SPgXA@mail.gmail.com>
Message-ID: <20140509205218.GA16051@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 03:31:53PM -0500, Thor Thayer wrote:
> Yes, good point. Our hardware can't recover from Double Bit Errors so
> I'll go back to the panic() in that path. I like the flexibility of
> the command line parameter though...

Like to panic by default when the machine is booted normally but to be
able to turn off the panicking with a module parameter?

If so, then you could probably implement a trivial setter called

edac_mc_set_panic_on_ue() in a separate patch.

Then, you call it at the end of altr_sdram_probe().

If you want to turn it off again, you do

echo "0" > /sys/module/edac_core/parameters/edac_mc_panic_on_ue

Something like that...

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
