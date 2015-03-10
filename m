From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 10 Mar 2015 10:08:46 +0100
Subject: [PATCH 0/3] add power-supply support to dw_hdmi
In-Reply-To: <1429128.MSqYm0qZ9p@phil>
References: <1429128.MSqYm0qZ9p@phil>
Message-ID: <1425978526.3141.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 10.03.2015, 00:21 +0100 schrieb Heiko Stuebner:
> At least the Rockchip variant of the dw_hdmi should control its supplying
> regulators. A cursory glance at the imx manual didn't any equivalent there,
> so I'm not sure if there are similar controllable regulators present.

On i.MX6 the HDMI_VP (1.1 V) and HDMI_VPH (2.5 V) are usually supplied
by the internal LDO_SoC via VDD_SOC_CAP (also used for ARM cache, SATA,
and PCIe) and the LDO_2P5 via VDDHIGH_CAP (also used for PLLs, MIPI,
SATA, PCIe, USB, and LVDS), respectively.
While I haven't seen anyone ever do this, it should be possible to
supply them from an external regulator.

regards
Philipp
