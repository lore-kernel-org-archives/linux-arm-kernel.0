From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 Dec 2017 08:57:35 +0100
Subject: [PATCH] arm64: allwinner: a64: orangepi-zero-plus2: add usb otg
In-Reply-To: <CAD6G_RQkBWth6iygyGfBX_rROEM7XUh3BmvoXfsxm8=po+kksQ@mail.gmail.com>
References: <1512644748-14491-1-git-send-email-jagan@amarulasolutions.com>
 <20171207133409.cpp7wxx4yflkgavp@flea.lan>
 <CAD6G_RQkBWth6iygyGfBX_rROEM7XUh3BmvoXfsxm8=po+kksQ@mail.gmail.com>
Message-ID: <20171208075735.nk5gsdpmbrol7fnq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 10:23:18PM +0530, Jagan Teki wrote:
> On Thu, Dec 7, 2017 at 7:04 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Thu, Dec 07, 2017 at 04:35:48PM +0530, Jagan Teki wrote:
> >> Add usb otg support for orangepi-zero-plus2 board:
> >> - Add usb_otg node with dr_mode as 'otg'
> >> - USB0-IDDET connected to PA21
> >> - VBUS connected through DCIN which always on
> >>
> >> Tested mass storage function.
> >>
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > Did you test the OTG or peripheral modes?
> 
> dr_mode with otg and I've tested mas storage gadget with mmc disk
> emulation.

So, peripheral, not OTG.

> >
> >> Note: Anyone please check vbus connection [1]
> >> Since it is connected through DCIN of vcc-5v, I've added vcc-5v0
> >> regulator for the same and attached to usb0_vbus-supply but it is
> >> disabling during kernel boot.
> >> [    1.887854] vcc5v0: disabling
> >
> > VBUS is the power line that is provided on the USB connector. In
> > peripheral, that power is provided by the host, therefore it needs to
> > be shutdown on the peripheral end. This is the expected behaviour.
> 
> So, in my test with 'otg' host drive the vbus so-it is disabling at
> target end is it?

You're not testing OTG, you're testing in peripheral mode. OTG is
switching between host and peripheral at runtime. And I'm pretty sure
this board cannot implement OTG at all, since its only source of power
seems to be USB.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171208/42843309/attachment.sig>
