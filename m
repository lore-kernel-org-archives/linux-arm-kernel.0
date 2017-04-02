From: guy.shapiro@mobi-wize.com (Guy Shapiro)
Date: Sun, 2 Apr 2017 10:15:42 +0300
Subject: proper power off implementation for iMX6 with external pmic
In-Reply-To: <d8d013f7-9417-c7c9-5f60-dd33465e9b42@pengutronix.de>
References: <d8d013f7-9417-c7c9-5f60-dd33465e9b42@pengutronix.de>
Message-ID: <ee04d494-4fe4-9fb2-ab47-cf46675c827e@mobi-wize.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/03/2017 14:02, Oleksij Rempel wrote:

> Hallo all,
>
> i'm looking for proper way to implement pm_power_off for IMX6 with external PMIC.
>
> http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
> page 5083
>
> According to this documentation, there are two ways to power off, depending on board configuration. With internal and external PMIC.
>
> Internal variant is implemented in:
> drivers/power/reset/imx-snvs-poweroff.c
>
Currently all the mainline DT definitions use the syscon-poweroff driver
and not imx-snvs-poweroff.  The syscon-poweroff binding includes the
bits to set on the "snvs_lp control register". One of those bits is
"Dumb PMIC Enable" (DP_EN) that looks related to the external PMIC mode.

I never tried to use the external PMIC mode myself. If I had to, I would
start by clearing this bit.

Guy.
