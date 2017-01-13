From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 13 Jan 2017 12:59:32 +0100
Subject: [PATCH v3 05/24] ARM: dts: imx6qdl-sabrelite: remove erratum
 ERR006687 workaround
In-Reply-To: <1483755102-24785-6-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-6-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1484308772.31475.25.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 06.01.2017, 18:11 -0800 schrieb Steve Longerbeam:
> There is a pin conflict with GPIO_6. This pin functions as a power
> input pin to the OV5642 camera sensor, but ENET uses it as the h/w
> workaround for erratum ERR006687, to wake-up the ARM cores on normal
> RX and TX packet done events. So we need to remove the h/w workaround
> to support the OV5642. The result is that the CPUidle driver will no
> longer allow entering the deep idle states on the sabrelite.
> 
> This is a partial revert of
> 
> commit 6261c4c8f13e ("ARM: dts: imx6qdl-sabrelite: use GPIO_6 for FEC
> 			interrupt.")
> commit a28eeb43ee57 ("ARM: dts: imx6: tag boards that have the HW workaround
> 			for ERR006687")
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>

Pity this has to be removed for all, Nitrogen6X should really use DT
overlays for the add-on boards / cameras.

regards
Philipp
