From: G.Schenk@eckelmann.de (Schenk, Gavin)
Date: Thu, 26 Apr 2018 06:06:01 +0000
Subject: [PATCH 1/2] can: flexcan: fix endianess detection
In-Reply-To: <20180425145040.22031-2-u.kleine-koenig@pengutronix.de>
References: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
 <20180425145040.22031-2-u.kleine-koenig@pengutronix.de>
Message-ID: <59d27567946e3c11b7cce38dfc773405cb0046d3.camel@eckelmann.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> In commit 88462d2a7830 ("can: flexcan: Remodel FlexCAN register r/w APIs
> for big endian FlexCAN controllers.") the following logic was
> implemented:
> 
> 	if the dt property "big-endian" is given or
> 	   the device is compatible to "fsl,p1010-flexcan":
> 		use big-endian mode;
> 	else
> 		use little-endian mode;
> 
> This relies on commit d50f4630c2e1 ("arm: dts: Remove p1010-flexcan
> compatible from imx series dts") which was applied a few commits later.
> Without this commit (or an old device tree used for booting a new
> kernel) the flexcan devices on i.MX25, i.MX28, i.MX35 and i.MX53 match
> the 'the device is compatible to "fsl,p1010-flexcan"' test and so are
> switched erroneously to big endian mode.
> 
> Instead of the check above put a flag into devtype data and rely on
> of_match_device yielding the most compatible match
> 
> Fixes: 88462d2a7830 ("can: flexcan: Remodel FlexCAN register r/w APIs for big
> endian FlexCAN controllers.")
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Tested-by: Gavin Schenk <g.schenk@eckelmann.de>

Regards
Gavin Schenk
