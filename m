From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Feb 2013 10:19:47 -0800
Subject: [GIT PULL] ARM part of USB patches
In-Reply-To: <20130205172724.GA1601@kroah.com>
References: <51112418.5020000@ti.com> <51112495.4060908@ti.com>
 <20130205172724.GA1601@kroah.com>
Message-ID: <20130205181947.GI25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* gregkh at linuxfoundation.org <gregkh@linuxfoundation.org> [130205 09:28]:
> On Tue, Feb 05, 2013 at 08:56:13PM +0530, kishon wrote:
> > Hi Tony, Greg,
> > 
> > On Tuesday 05 February 2013 08:54 PM, kishon wrote:
> > >Hi Tony,
> > >
> > >As discussed, I'm sending a pull request for the arch/arm part of my USB
> > >patches. These patches are necessary to get MUSB functional in both dt
> > >and non-dt boot. Also added dt data for dwc3 present in OMAP. This patch
> > >series *depends* on some of the patches which are merged in usb-next.
> > 
> > This patch series should go in only after USB. Or else it will break
> > compilation.
> 
> Then it probably should go through the USB tree, right?  We don't want
> to break bisectability.

Looks like this branch needs to be based on at least 01658f0f (usb: phy:
add a new driver for usb part of control module) to compile. Probably
needs other USB patches too to make sense.

This branch has a high likelihood of conflicting with .dts files, so
Kishon, I suggest you do two branches:

1. A branch for Greg based on top of the USB changes

   This branch should contain:

   ARM: OMAP4: remove control module address space from PHY and OTG
   ARM: OMAP: devices: create device for usb part of control module
   ARM: OMAP2: MUSB: Specify omap4 has mailbox
   ARM: OMAP: USB: Add phy binding information

   Naturally please make sure they compile and boot on their own.
   Looks like this will only cause few trivial include merge conflicts
   with what I have queued up.

   You can add my Acked-by: Tony Lindgren <tony@atomide.com> for those.

2. A branch for Benoit based on v3.8-rc6

   That branch should contain all the .dts changes as those will
   most likely cause nasty merge conflicts otherwise with what
   Benoit has queued up.

Regards,

Tony
