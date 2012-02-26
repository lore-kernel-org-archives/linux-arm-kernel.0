From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 27 Feb 2012 00:47:01 +0100
Subject: [PATCH 2/3] ARM: PXA27x: save/restore PWER on suspend/resume
In-Reply-To: <20120226233648.GD4706@n2100.arm.linux.org.uk>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
 <201202262320.27934.marek.vasut@gmail.com>
 <20120226233648.GD4706@n2100.arm.linux.org.uk>
Message-ID: <201202270047.01509.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sun, Feb 26, 2012 at 11:20:27PM +0100, Marek Vasut wrote:
> > > On Sun, Feb 26, 2012 at 04:47:41PM +0300, Vasily Khoruzhick wrote:
> > > > Bootloader can clobber PWER value, so save it state on suspend.
> > > 
> > > What boot loader is this,
> > 
> > U-Boot, patched, not mainline.
> > 
> > > and why is it being so idiotic?
> > 
> > Mainline doesn't touch PWER, so please be careful about your accusations.
> > 
> > > Why can't it
> > > be fixed?
> > 
> > Yes, either by using mainline uboot (to rule out the bootloader problem),
> > finding bug in linux kernel or reading the CPU manual.
> 
> Was there supposed to be any useful information in your reply, or are
> you just trying to be your usual antagonistic self?

Um ... 

1) PWER isn't reconfigured by uboot (see above)
2) That you should try mainline uboot to avoid debugging problems with not-
mainlined patches
3) That the bug with PWER is likely in kernel, since there's an issue with 
gpio_set_wake() on PXA
4) That the CPU might not preserve PWER throughout the suspend and that this 
information might be found in the CPU manual

I was a bit terse there, sorry.

M
