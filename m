From: balbi@ti.com (Felipe Balbi)
Date: Fri, 10 Aug 2012 09:16:17 +0300
Subject: [PATCH v3 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
In-Reply-To: <CAD6zSYP33PDrXwifQM=7q+Esk1X7m5+DNG_=A2a-qTENk4zq8w@mail.gmail.com>
References: <1344411661-17821-1-git-send-email-p.paneri@samsung.com>
 <502464FE.3000908@samsung.com>
 <CAD6zSYP33PDrXwifQM=7q+Esk1X7m5+DNG_=A2a-qTENk4zq8w@mail.gmail.com>
Message-ID: <20120810061616.GC1689@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Fri, Aug 10, 2012 at 11:17:29AM +0530, Praveen Paneri wrote:
> On Fri, Aug 10, 2012 at 7:03 AM, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
> > Hi, Praveen.
> >
> >
> > On 08/08/2012 04:40 PM, Praveen Paneri wrote:
> >>
> >> Changes from v2:
> >> Changed the driver filenames to samsung-usbphy
> >> Changed 's3c' to 'samsung' for platform device as well as platform data
> >> Moved platform data structure to a separate file
> >> Rectified coding style related errors
> >>
> >> Changes from v1:
> >> Rebased patches to latest usb-next branch
> >> Changed the name 'sec_usbphy' to 'samsung_usbphy'
> >>
> >> This patch set introduces a phy driver for samsung SoCs. It uses the
> >> existing
> >> transceiver infrastructure to provide phy control functions. Use of this
> >> driver
> >> can be extended for usb host phy as well.
> >
> >
> > How can you support usb host phy? I cannot choose to use which phy when
> > call init or shutdown of phy at current phy framework.

correct. Curretly that's not supported. We are trying to come up with
proper DeviceTree bindings to allow that. Kishon has been working on
providing devm_usb_get_phy_by_phandle() would should help achieving what
you need.

> If you are talking about choosing between PHY0 (for device) and PHY1
> (for host), I think you can make use of the flags available in usb_phy
> to pass that information to phy driver and that can be handled there.

I rather you didn't do it that way. Those flags are used to pass
features to the PHY. See drivers/usb/otg/ulpi.c, for instance.

> This is just one way I have successfully implement two different phy
> control. There might be a better way to do that.

I guess using DT phandles is the way to go here.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120810/cabed923/attachment.sig>
