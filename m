From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Apr 2013 10:23:53 -0700
Subject: Multiple issues with omap4 panda es in linux next
In-Reply-To: <5176A45B.5@ti.com>
References: <20130419171318.GK10155@atomide.com> <5174F7A8.7070308@ti.com>
 <20130422180316.GA10155@atomide.com> <5176A45B.5@ti.com>
Message-ID: <20130423172353.GD10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [130423 08:15]:
> >>>2. MUSB fails with legacy booting and DT on panda es
> >>>
> >>>With both legacy and DT booting I get something like:
> >>>
> >>>HS USB OTG: no transceiver configured
> >>>musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
> >>
> >>The dt should work fine with https://patchwork.kernel.org/patch/2423061/.
> >
> >OK thanks for checking that.
> >
> >>But non-dt has got a real issue. We were using usb_bind_phy() for
> >>binding the controller with the PHY (we use device names). But in
> >>linux-next the device names have changed because of using
> >>PLATFORM_DEVID_AUTO. We can modify the usb_bind_phy() calls to use
> >>the new device names, But I suspect the device names can change
> >>again. Not sure what we can do here :-(
> >
> >Let's do a minimal fix for v3.10. Then we'll make omap4 DT only for
> >v3.11 and that problem is solved for good.
> 
> Have posted a patch https://patchwork.kernel.org/patch/2475521/ for
> getting MUSB functional in omap4 panda.

OK thanks. Paul it seems that this patch is still queued in one of
your branches?

Let me know if you want me to pick that one up for fixes for the
merge window, or if you have multiple patches to pull.

Regards,

Tony
