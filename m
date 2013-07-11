From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 11 Jul 2013 09:55:43 +0200
Subject: [v4 3/3] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <0E83723C55F66F43A6041464FE31119D32AE6B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1373445355-11453-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373445355-11453-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130710210414.GK516@pengutronix.de>
 <0E83723C55F66F43A6041464FE31119D32AE6B@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20130711075543.GG14452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Thu, Jul 11, 2013 at 07:50:50AM +0000, Zhu Richard-R65037 wrote:
> Hi Sascha:
> Sorry to make a mess on the usage of the private data.
> The private data of "imx_ahci_pdev" platform device would be used to store ata_host point.
> I shouldn't set imxpriv to the private data of "imx_ahci_pdev", so do the wrong assignment of
> The private pointer of device.

Please allocate your private data along with the platform_device in the
probe function, then in the init callback you can use container_of() to
get a pointer to the data.
Also I would recommend you to request the necessary resources (clocks,
regmap) in the probe function and not in the init callback.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
