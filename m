From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 31 Jul 2012 17:06:33 +0800
Subject: [PATCH v3 1/3] USB: chipidea: add imx usbmisc support
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803C0B776@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1343298916-11101-1-git-send-email-richard.zhao@freescale.com>
 <1343298916-11101-2-git-send-email-richard.zhao@freescale.com>
 <20120730093244.GQ30009@pengutronix.de>
 <20120730093956.GI3347@b20223-02.ap.freescale.net>
 <F281D0F91ED19E4D8E63A7504E8A649803C0B776@039-SN2MPN1-022.039d.mgd.msft.net>
Message-ID: <20120731090632.GK3347@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 09:06:33AM +0800, Chen Peter-B29397 wrote:
>  
> > >
> > > <&usbmisc 0> would then mean port 0 of the usbmisc device.
> > I didn't add the restriction that a usbmisc driver must have a usbmisc
> > device. I'm not sure whether all SoC and future SoC can be look as
> > a device.
> > 
> > Peter, do you have any idea?
> > 
> I have not followed this usbmisc design, I just list some facts at i.mx
> USB controller:
> 
> Sigmatel-derived SoCs (i.mx23, i.mx28) have no this register region, all phy controls
> are through PHY register.
> Other freescale SoCs have this usbmisc register region to control phy and tune some
> signal quality. This register region is from another 0x800 or (last controller base address + 0x200) 
Looks good. I'll take Sascha's suggestion.

Thanks
Richard
> 
> > Thanks
> > Richard
> > >
> > > If the usbmisc property exists, you can return -EPROBE_DEFER until it
> > is
> > > available. If it doesn't exist, you just continue without usbmisc
> > > support (i.MX28)
> > >
> > > Sascha
> > >
> > >
> > > --
> > > Pengutronix e.K.                           |
> > |
> > > Industrial Linux Solutions                 | http://www.pengutronix.de/
> > |
> > > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> > |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-
> > 5555 |
> > >
