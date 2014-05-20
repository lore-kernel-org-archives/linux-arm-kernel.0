From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 20 May 2014 12:55:04 -0700
Subject: [PATCH v3 4/9] of: mtd: add documentation for the ONFI NAND
 timing mode property
In-Reply-To: <20140520195140.GA32287@obsidianresearch.com>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
 <1394647664-8258-5-git-send-email-b.brezillon.dev@gmail.com>
 <20140520182542.GS28907@ld-irv-0074>
 <537BAD59.3060902@free-electrons.com>
 <20140520195140.GA32287@obsidianresearch.com>
Message-ID: <20140520195504.GX28907@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 01:51:40PM -0600, Jason Gunthorpe wrote:
> On Tue, May 20, 2014 at 09:30:33PM +0200, Boris BREZILLON wrote:
> > AFAICT nothing, but the same goes for the ECC requirements, and we've
> > recently added DT bindings to define these requirements.
> > I'm not telling we should drop these ECC requirements bindings (actually
> > I'm using them :-)), but what's different with the timings requirements ?
> 
> ECC requirements are almost always something that has to be matched to
> the bootloader (since the bootloader typicaly reads the NAND to boot),
> so it is sensible to put that in the DT

+1 You beat me to this :)

> The timings are a property of the chip, and if they can be detected
> they should be. IMHO, the main purpose of a DT property would be to
> lower the speed if, for some reason, the board cannot support the
> device's full speed.

Agreed.

Now, we still have the open question of whether we can autodetect timing
modes easily for non-ONFI chips.

> > Indeed, I based it on the ONFI NAND timings mode model, but AFAIK
> > (tell me if I'm wrong), it should work because most of the timings
> > are min requirements.  This means, even if you provide slower
> > signals transitions, the NAND will work as expected.
> 
> IIRC for ONFI a device must always work in the mode 0 timings, without
> requiring a command?

I believe so.

FYI, despite the name of the binding, we are mostly interested in
non-ONFI NAND here.

Brian
