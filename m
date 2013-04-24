From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Apr 2013 12:08:21 -0700
Subject: Multiple issues with omap4 panda es in linux next
In-Reply-To: <517770A0.4000609@ti.com>
References: <20130419171318.GK10155@atomide.com> <5174F7A8.7070308@ti.com>
 <20130422180316.GA10155@atomide.com> <5176A45B.5@ti.com>
 <20130423172353.GD10155@atomide.com>
 <20130423213151.GM10155@atomide.com>
 <20130423231605.GO10155@atomide.com> <517770A0.4000609@ti.com>
Message-ID: <20130424190821.GB5184@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [130423 22:46]:
> Hi Tony,
> 
> On Wednesday 24 April 2013 04:46 AM, Tony Lindgren wrote:
> >* Tony Lindgren <tony@atomide.com> [130423 14:37]:
> >>* Tony Lindgren <tony@atomide.com> [130423 10:28]:
> >>>* Kishon Vijay Abraham I <kishon@ti.com> [130423 08:15]:
> >>>>>>>2. MUSB fails with legacy booting and DT on panda es
> >>>>>>>
> >>>>>>>With both legacy and DT booting I get something like:
> >>>>>>>
> >>>>>>>HS USB OTG: no transceiver configured
> >>>>>>>musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
> >>>>>>
> >>>>>>The dt should work fine with https://patchwork.kernel.org/patch/2423061/.
> >>>>>
> >>>>>OK thanks for checking that.
> >
> >Kishon, I think there's also some other issue remaining
> >in linux next with MUSB and DT. I'm still getting the
> >"HS USB OTG: no transceiver configured" although the nop
> >xceiv is compiled in. Maybe give it a try against linux
> >next?
> 
> For OMAP4 MUSB, you'll need omap-usb2 phy. I've attached my .config.

Thanks your config helped me to track it down. Looks like I got
the PHYs the wrong way around between EHCI and MUSB..

In any case, I did have omap-usb2 compiled in, but I did not have
OMAP_OCP2SCP=y set. Should OMAP_USB2 depend on that?

Also, looks like MUSB just sits in b_idle mode though, so no more
ID pin interrupt for some reason.

Regards,

Tony
