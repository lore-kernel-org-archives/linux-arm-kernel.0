From: bp@alien8.de (Borislav Petkov)
Date: Fri, 9 May 2014 15:52:59 +0200
Subject: [PATCHv3 3/3] edac: altera: Add EDAC support for Altera SDRAM
In-Reply-To: <CAF03EBecxtMr1670ktQKTAZX_kHeZWz1SwuEk373B99BoVjbDw@mail.gmail.com>
References: <1399330337-16748-1-git-send-email-tthayer@altera.com>
 <1399330337-16748-4-git-send-email-tthayer@altera.com>
 <20140508120524.GF12548@pd.tnic>
 <CAF03EBecxtMr1670ktQKTAZX_kHeZWz1SwuEk373B99BoVjbDw@mail.gmail.com>
Message-ID: <20140509135259.GC16260@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 03:37:19PM -0500, Thor Thayer wrote:
> Yes. Their reasoning is that they want to retain the rights and
> warranty language with the file (just in case the COPYING file
> changes).

Ok, thanks for checking up on this.

> Yes. I tested using edac_core.edac_mc_panic_on_ue=1 from the command
> line and it worked fine. I'll add a comment to clarify. BTW, thanks
> for your help on that.

Sure, but the question still remains: do you want to panic on
uncorrectable errors by default or want the user to decide? I guess this
is something you can answer for your hardware...

> I considered using "volatile" variables, but decided against it after
> I read Documentation/volatile-considered-harmful.txt and my situation
> doesn't fit into the exemptions. Is there a better way to handle this?

Off the top of my head, I'd first look at compiler asm output to
check what my compiler does with those writes and then take a look at
employing the ACCESS_ONCE macro or something similar where we use the
asm volatile() as an optimization stop for the compiler, among others.

And then I'll look at asm again to make sure it does what it is supposed
to do. Something to that effect, in any case...

HTH.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
