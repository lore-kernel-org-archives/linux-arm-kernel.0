From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jun 2011 10:52:17 +0100
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612093822.GB29516@S2100-06.ap.freescale.net>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612081541.GA10283@n2100.arm.linux.org.uk>
	<20110612083414.GA29516@S2100-06.ap.freescale.net>
	<20110612092131.GC10283@n2100.arm.linux.org.uk>
	<20110612093822.GB29516@S2100-06.ap.freescale.net>
Message-ID: <20110612095217.GD10283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 05:38:23PM +0800, Shawn Guo wrote:
> On Sun, Jun 12, 2011 at 10:21:31AM +0100, Russell King - ARM Linux wrote:
> > What if your platform doesn't use uboot?
> 
> Add dtb parsing support with the help from libfdt, I guess.  It is
> some amount of work, but it's not a rewrite of bootloader, IMHO.

I guess you're suggesting that this wrapper uses libfdt to merge
the ATAGs with the DT info?

I think this is getting messy - and I think that we've made a design
error with the boot process in thinking that we'll have either ATAGs
_or_ DT.  While we can continue to stuff the early kernel parts like
decompressors and such like with this stuff, it's getting painful and
over complicated.

It would have been far better to have passed both the ATAGs _and_ DT
to the kernel directly and let it sort them out without having to
teach several layers about DT parsing.
