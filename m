From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sun, 12 Jun 2011 13:22:19 +0200
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612083414.GA29516@S2100-06.ap.freescale.net>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612081541.GA10283@n2100.arm.linux.org.uk>
	<20110612083414.GA29516@S2100-06.ap.freescale.net>
Message-ID: <20110612112219.GD16318@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawn.guo@freescale.com> [2011-06-12 16:34:15]:

> On Sun, Jun 12, 2011 at 09:15:41AM +0100, Russell King - ARM Linux wrote:
> > 
> > One thing which has been bugging me for some time is that the DT stuff
> > completely overrides the ATAGs.  This is wrong with solutions like this.
> > 
> > We have a set of perfectly good boot loaders which provide correct
> > information to the kernel via ATAGs.  If we start moving everything
> > over to DT, then we run into a problem because the ATAGs are ignored -
> > stuff such as the RAM size and command line passed from the boot loader
> > will be entirely ignored, instead these having to be encoded into the
> > kernel at build time.
> > 
> What u-boot does right now is replacing the parameters in dtb with
> its for those it's interested in, for example command line is one,
> before it passes dtb to kernel.

If I understand it all correctly, there must be some 'legacy bootloader
support' added to the kernel, layer which would convert the ATAGs to the DT.
Or something like that.

Please note, that there are some boards out there, which use some kind of
proprietary bootloaders, so you can't update or change them easily. You either
don't have source code, you're limited by the available space (2KB eeprom) so
you can't add much more things into that bootloader or you're limited by the
size of the MBR (yes, even such bootloaders exists).

Ok, everything could be reverse engineered, EEPROM could be exchanged for the
bigger one etc., second stage bootloader could be written for the MBR one, but
it's not as easy as you think, at least not as "Add dtb parsing support with
the help from libfdt. It is some amount of work, but it's not a rewrite of
bootloader, IMHO."

-- ynezz
