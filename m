From: yibin.gong@nxp.com (Robin Gong)
Date: Mon, 6 Aug 2018 02:51:38 +0000
Subject: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
In-Reply-To: <403db02e-9c91-5080-ee9c-7a44716e64b2@pengutronix.de>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
 <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <403db02e-9c91-5080-ee9c-7a44716e64b2@pengutronix.de>
Message-ID: <DB6PR04MB3223921579ED18FDD802A73F89200@DB6PR04MB3223.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +static struct pfuze_chip *syspm_pfuze_chip;
> >> +
> >> +static void pfuze_power_off_prepare(void)
> >> +	dev_info(syspm_pfuze_chip->dev, "Configure standy mode for power
> >> +off");
> > Add 'if (syspm_pfuze_chip ->chip_id == PFUZE100))' here is easy for
> > extend Support on pfuze200/3000.. in the feature.
> There is already:
> static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip) {
>         if (pfuze_chip->chip_id != PFUZE100) {
>                 dev_warn(pfuze_chip->dev, "Requested
> pm_power_off_prepare handler for not supported chip\n");
>                 return -ENODEV;
>         }
> 
> 
> No need to add it in pfuze_power_off_prepare()
I saw you add chip check in pfuze_power_off_prepare_init(), but I'm saying
In the future case pfuze200/3000 may should still support this feature, but registers
are different between different chips, thus, move checking chip into pfuze_power_off_prepare()
could make the later patch for pfuze200/3000 more clear, less and easier.
