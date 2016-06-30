From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 29 Jun 2016 18:29:02 -0700
Subject: [PATCH 09/21] usb: chipidea: Add support for ULPI PHY bus
In-Reply-To: <20160629062600.GD25236@shlinux2>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-10-stephen.boyd@linaro.org>
 <20160629062600.GD25236@shlinux2>
Message-ID: <146725014292.32568.4079956848878937988@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-06-28 23:26:00)
> On Sun, Jun 26, 2016 at 12:28:26AM -0700, Stephen Boyd wrote:
> > @@ -187,6 +190,7 @@ struct hw_bank {
> >   * @test_mode: the selected test mode
> >   * @platdata: platform specific information supplied by parent device
> >   * @vbus_active: is VBUS active
> > + * @ulpi: pointer to ULPI device, if any
> 
> One more kernel-doc

Done.

> 
> >   * @phy: pointer to PHY, if any
> >   * @usb_phy: pointer to USB PHY, if any and if using the USB PHY framework
> >   * @hcd: pointer to usb_hcd for ehci host driver
> > @@ -236,6 +240,10 @@ struct ci_hdrc {
> >  
> >       struct ci_hdrc_platform_data    *platdata;
> >       int                             vbus_active;
> > +#ifdef CONFIG_USB_CHIPIDEA_ULPI
> > +     struct ulpi                     *ulpi;
> > +     struct ulpi_ops                 ulpi_ops;
> > +#endif
> >       struct phy                      *phy;
> >       /* old usb_phy interface */
> >       struct usb_phy                  *usb_phy;
> > @@ -418,6 +426,17 @@ static inline bool ci_otg_is_fsm_mode(struct ci_hdrc *ci)
> >  #endif
> >  }
> >  
> 
> Others are ok, but I can't accept you change current PHY initialization
> at your previous patch, so you may need to refine this patch a little.
> 

Ok. No problem.
