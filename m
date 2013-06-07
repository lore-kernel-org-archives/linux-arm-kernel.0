From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Jun 2013 23:20:51 +0100
Subject: [PATCH] ARM: mach-imx6q: Enable the codec clock earlier
In-Reply-To: <1370642870-8051-1-git-send-email-festevam@gmail.com>
References: <1370642870-8051-1-git-send-email-festevam@gmail.com>
Message-ID: <20130607222051.GD18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 07:07:50PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> In order sgtl5000 driver to probe successfully, we need to read its ID via I2C 
> ,which requires that MCLK is driven prior to the I2C access.
> 
> Otherwise we get the following probe error:
> 
> sgtl5000: probe of 0-000a failed with error -5
> imx-sgtl5000 sound.13: ASoC: CODEC (null) not registered
> imx-sgtl5000 sound.13: snd_soc_register_card failed (-517)
> platform sound.13: Driver imx-sgtl5000 requests probe deferral
> 
> Turn on MCLK sooner so that the probe can succeed.

Umm... doesn't that mean that imx-sgtl5000 should be getting this clock
and turning it on itself, and disabling it on device removal?
