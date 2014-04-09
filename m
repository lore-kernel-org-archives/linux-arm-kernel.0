From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 9 Apr 2014 09:11:34 +0200
Subject: [PATCH 2/3] ARM i.MX6: Fix ethernet PLL clocks
In-Reply-To: <20140409065952.GD2611@dragon>
References: <1353578358-23509-1-git-send-email-s.hauer@pengutronix.de>
 <1353578358-23509-3-git-send-email-s.hauer@pengutronix.de>
 <20121122113226.GJ24693@S2100-06.ap.freescale.net>
 <20121122123535.GD10369@pengutronix.de> <5343E106.7070902@de.bosch.com>
 <20140409065952.GD2611@dragon>
Message-ID: <5344F2A6.7080401@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.04.2014 08:59, Shawn Guo wrote:
> On Tue, Apr 08, 2014 at 01:44:06PM +0200, Dirk Behme wrote:
>> I'm no expert on this, but it seems to be able to use 100MHz or
>> 125Mhz enet clock, you additionally have to set the ENABLE_100M
>> (CCM_ANALOG_PLL_ENET[20]) or ENABLE_125M (CCM_ANALOG_PLL_ENET[19])
>> bits. Which isn't done by above change,
>
> The following two lines added by the patch should just do.
>
> 	clk[sata_ref_100m] = imx_clk_gate("sata_ref_100m", "sata_ref", base + 0xe0, 20);
> 	clk[pcie_ref_125m] = imx_clk_gate("pcie_ref_125m", "pcie_ref", base + 0xe0, 19);

Many thanks, we'll test that :)

It seems that it's unsure at the moment if ENABLE_100M 
(CCM_ANALOG_PLL_ENET[20]) or ENABLE_125M (CCM_ANALOG_PLL_ENET[19]) are 
really needed, though ...

Many thanks and best regards

Dirk
