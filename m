From: oleksandrs@mellanox.com (Oleksandr Shamray)
Date: Fri, 1 Dec 2017 11:11:03 +0000
Subject: [patch v12 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <CAGMNF6XRwU5QEJhkg-mVwE5zpPigtcGJtRUupZHtcWRdedcsxg@mail.gmail.com>
References: <1510675867-24276-1-git-send-email-oleksandrs@mellanox.com>
 <1510675867-24276-3-git-send-email-oleksandrs@mellanox.com>
 <CAGMNF6XRwU5QEJhkg-mVwE5zpPigtcGJtRUupZHtcWRdedcsxg@mail.gmail.com>
Message-ID: <AM4PR0501MB21946528385296CCEEBFEB1AB1390@AM4PR0501MB2194.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kun Yi [mailto:kunyi at google.com]
> Sent: Thursday, November 30, 2017 12:51 AM
> To: Oleksandr Shamray <oleksandrs@mellanox.com>
> Cc: gregkh at linuxfoundation.org; arnd at arndb.de; system-sw-low-level
> <system-sw-low-level@mellanox.com>; devicetree at vger.kernel.org;
> jiri at resnulli.us; Vadim Pasternak <vadimp@mellanox.com>; linux-
> api at vger.kernel.org; OpenBMC Maillist <openbmc@lists.ozlabs.org>; linux-
> kernel at vger.kernel.org; openocd-devel-owner at lists.sourceforge.net;
> mec at shout.net; Jiri Pirko <jiri@mellanox.com>; robh+dt at kernel.org; linux-
> serial at vger.kernel.org; tklauser at distanz.ch; mchehab at kernel.org;
> davem at davemloft.net; linux-arm-kernel at lists.infradead.org
> Subject: Re: [patch v12 2/4] drivers: jtag: Add Aspeed SoC 24xx and 25xx
> families JTAG master driver
> 
> Thanks for working on the driver, Oleksandr. I gave this a try on a board with
> Aspeed 2520. One question below:
> 
> On Tue, Nov 14, 2017 at 8:11 AM, Oleksandr Shamray
> <oleksandrs@mellanox.com> wrote:
> > Driver adds support of Aspeed 2500/2400 series SOC JTAG master controller.
> >
> > Driver implements the following jtag ops:
> > - freq_get;
> > - freq_set;
> > - status_get;
> > - idle;
> > - xfer;
> >

[..]

> > +
> > +static const struct jtag_ops aspeed_jtag_ops = {
> > +       .freq_get = aspeed_jtag_freq_get,
> > +       .freq_set = aspeed_jtag_freq_set,
> > +       .status_get = aspeed_jtag_status_get,
> > +       .idle = aspeed_jtag_idle,
> > +       .xfer = aspeed_jtag_xfer,
> > +       .mode_set = aspeed_jtag_mode_set };
> > +
> > +static int aspeed_jtag_probe(struct platform_device *pdev) {
> > +       struct aspeed_jtag *aspeed_jtag;
> > +       struct jtag *jtag;
> > +       int err;
> > +
> > +       if (!of_device_is_compatible(pdev->dev.of_node,
> > + "aspeed,aspeed-jtag"))
> 
> Should this be "aspeed,ast2400-jtag"/"aspeed,ast2500-jtag" as specified in the
> compatible string below?
> 

Yes


> > +               return -ENOMEM;
> > +
> > +       jtag = jtag_alloc(sizeof(*aspeed_jtag), &aspeed_jtag_ops);
> > +       if (!jtag)
> > +               return -ENODEV;
> > +
> > +       platform_set_drvdata(pdev, jtag);
> > +       aspeed_jtag = jtag_priv(jtag);
> > +       aspeed_jtag->dev = &pdev->dev;
> > +
 
[..]

> > +
> > +MODULE_AUTHOR("Oleksandr Shamray <oleksandrs@mellanox.com>");
> > +MODULE_DESCRIPTION("ASPEED JTAG driver"); MODULE_LICENSE("GPL
> v2");
> > --
> > 1.7.1
> >
> --
> Regards,
> Kun

Thanks.

BR
Oleksandr Shamray
