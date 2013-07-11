From: r65037@freescale.com (Zhu Richard-R65037)
Date: Thu, 11 Jul 2013 09:07:36 +0000
Subject: [v4 3/3] sata: imx: add ahci sata support on imx platforms
In-Reply-To: <20130711075543.GG14452@pengutronix.de>
References: <1373445355-11453-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1373445355-11453-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130710210414.GK516@pengutronix.de>
 <0E83723C55F66F43A6041464FE31119D32AE6B@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130711075543.GG14452@pengutronix.de>
Message-ID: <0E83723C55F66F43A6041464FE31119D32AF10@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha:
Thanks for your comments.
Yes, it is.
That's is what I done in the V5 patch-set. The patch-set is almost done, would send out a moment later.

Best Regards
Richard Zhu


-----Original Message-----
From: Sascha Hauer [mailto:s.hauer at pengutronix.de] 
Sent: Thursday, July 11, 2013 3:56 PM
To: Zhu Richard-R65037
Cc: Richard Zhu; shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org; jgarzik at pobox.com; tj at kernel.org; rob.herring at calxeda.com; linux-ide at vger.kernel.org
Subject: Re: [v4 3/3] sata: imx: add ahci sata support on imx platforms

Hi Richard,

On Thu, Jul 11, 2013 at 07:50:50AM +0000, Zhu Richard-R65037 wrote:
> Hi Sascha:
> Sorry to make a mess on the usage of the private data.
> The private data of "imx_ahci_pdev" platform device would be used to store ata_host point.
> I shouldn't set imxpriv to the private data of "imx_ahci_pdev", so do 
> the wrong assignment of The private pointer of device.

Please allocate your private data along with the platform_device in the probe function, then in the init callback you can use container_of() to get a pointer to the data.
Also I would recommend you to request the necessary resources (clocks,
regmap) in the probe function and not in the init callback.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
