From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 3 Jul 2012 09:02:40 +0200
Subject: [PATCH v2 3/4] usb: chipidea: ci13xxx-imx: add "dr_mode"
 property to device tree bindings
In-Reply-To: <20120703030049.GA3374@b20223-02.ap.freescale.net>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
 <1340891629-13145-4-git-send-email-mkl@pengutronix.de>
 <20120629014352.GA28923@b20223-02.ap.freescale.net>
 <4FED5D77.3050009@pengutronix.de>
 <20120629084509.GB28923@b20223-02.ap.freescale.net>
 <4FEDCF15.9040000@wwwdotorg.org>
 <20120630011906.GA2489@richard-laptop>
 <4FF1FEBC.3040107@wwwdotorg.org>
 <CAL411-oeVCsRxxHHWM4VEtbXBTK_Poyxtp0AK7K_4jEg8U1fJA@mail.gmail.com>
 <20120703030049.GA3374@b20223-02.ap.freescale.net>
Message-ID: <20466.39184.844238.739308@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Richard Zhao writes:
> On Tue, Jul 03, 2012 at 10:22:37AM +0800, Peter Chen wrote:
> > > Hmm. I think it'd be reasonable to use dr_mode like the other bindings,
> > > and have the default case be decided by the ID pin when dr_mode isn't
> > > specified. Having different defaults for different bindings seems pretty
> > > reasonable to me.
> > 
> > As far as I know, there is no USB Spec says the ID value should be
> > used at device or host mode. At USB device and host driver, there
> > should be NO ID related things, that is to say device or host driver
> > should not care ID is grounded or floated, as ID may be grounded
> > at device mode, and high at host mode for different board design.
> > ID interrupt should only be enabled when dr_mode = otg;
> I don't quite understand your point. All the discussions are based
> on otg controllers.
> > 
> > Board design and customized usage (user may want to use only device mode
> > for otg capable port) makes what USB role will be used
> > at driver, so dr_mode at dts (or pdata->dr_mode at non-dt solution) can make
> > the decision for driver how USB role will be used.
> That's the case we need the property. But for fine otg hw design, we
> don't need the property, right?
> 
> And to decide whether it's otg controller or not, the driver read the
> capability registers.
> 
A user may wish to restrict even a 'fine otg hw design' to be used in
pure host or device mode. That's where the dr_mode property jumps in.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
