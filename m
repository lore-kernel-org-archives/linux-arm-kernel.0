From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 3 Jul 2012 11:00:50 +0800
Subject: [PATCH v2 3/4] usb: chipidea: ci13xxx-imx: add "dr_mode"
 property to device tree bindings
In-Reply-To: <CAL411-oeVCsRxxHHWM4VEtbXBTK_Poyxtp0AK7K_4jEg8U1fJA@mail.gmail.com>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
 <1340891629-13145-4-git-send-email-mkl@pengutronix.de>
 <20120629014352.GA28923@b20223-02.ap.freescale.net>
 <4FED5D77.3050009@pengutronix.de>
 <20120629084509.GB28923@b20223-02.ap.freescale.net>
 <4FEDCF15.9040000@wwwdotorg.org>
 <20120630011906.GA2489@richard-laptop>
 <4FF1FEBC.3040107@wwwdotorg.org>
 <CAL411-oeVCsRxxHHWM4VEtbXBTK_Poyxtp0AK7K_4jEg8U1fJA@mail.gmail.com>
Message-ID: <20120703030049.GA3374@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 10:22:37AM +0800, Peter Chen wrote:
> > Hmm. I think it'd be reasonable to use dr_mode like the other bindings,
> > and have the default case be decided by the ID pin when dr_mode isn't
> > specified. Having different defaults for different bindings seems pretty
> > reasonable to me.
> 
> As far as I know, there is no USB Spec says the ID value should be
> used at device or host mode. At USB device and host driver, there
> should be NO ID related things, that is to say device or host driver
> should not care ID is grounded or floated, as ID may be grounded
> at device mode, and high at host mode for different board design.
> ID interrupt should only be enabled when dr_mode = otg;
I don't quite understand your point. All the discussions are based
on otg controllers.
> 
> Board design and customized usage (user may want to use only device mode
> for otg capable port) makes what USB role will be used
> at driver, so dr_mode at dts (or pdata->dr_mode at non-dt solution) can make
> the decision for driver how USB role will be used.
That's the case we need the property. But for fine otg hw design, we
don't need the property, right?

And to decide whether it's otg controller or not, the driver read the
capability registers.

Thanks
Richard
> 
> Marc's patch is almost OK, but better use below logic at core.c:
> If there is no dr_mode, it is better to indicate an error message and
> quit probe.
> 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
