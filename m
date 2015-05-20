From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Wed, 20 May 2015 10:12:44 +0300
Subject: [PATCH 01/15] thermal: consistently use int for temperatures
In-Reply-To: <1431507163-19933-2-git-send-email-s.hauer@pengutronix.de>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
 <1431507163-19933-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <555C33EC.7050906@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/15 11:52, Sascha Hauer wrote:
> The thermal code uses int, long and unsigned long for temperatures
> in different places. Using an unsigned type limits the thermal framework
> to positive temperatures without need. 'long' is 64bit on several
> architectures which is not needed. Consistently use a plain 'int'
> for temperatures.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> ...

It looks like some longs remain in db8500_thermal.c, int340x_thermal/*,
intel_soc_dts_thermal.c, kirkwood_thermal.c, rockchip_thermal.c and 
samsung/exynos_tmu.c. (found by 'grep -R long drivers/thermal/*)

Cheers,
Mikko.
