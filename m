From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Jan 2014 15:13:39 +0100
Subject: [PATCH v5 2/9] mfd: omap-usb-host: Get clocks based on hardware
 revision
In-Reply-To: <20140110102251.GH28141@lee--X1>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
 <1389269303-30465-3-git-send-email-rogerq@ti.com>
 <20140110102251.GH28141@lee--X1>
Message-ID: <201401101513.40470.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 January 2014, Lee Jones wrote:
> >  
> > -     need_logic_fck = false;
> > +     /* Set all clocks as invalid to begin with */
> > +     omap->ehci_logic_fck = omap->init_60m_fclk = ERR_PTR(-EINVAL);
> > +     omap->utmi_p1_gfclk = omap->utmi_p2_gfclk = ERR_PTR(-EINVAL);
> > +     omap->xclk60mhsp1_ck = omap->xclk60mhsp2_ck = ERR_PTR(-EINVAL);
> 
> I don't think this is the correct error code.
> 
> -EINVAL means 'invalid parameter'.
> 
> You probably want -ENODEV or -ENOSYS ('function not implemented'
> probably isn't ideal either tbh, but you get the idea). Perhaps you
> can set them as NULL and check for IS_ERR_OR_NULL() instead?

I think ENODEV is ok here, I'd much prefer this over IS_ERR_OR_NULL().

	Arnd
