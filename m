From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 12 Nov 2017 20:15:47 +0000
Subject: [PATCH v3 7/7] EDAC: Add driver for the Marvell Armada XP SDRAM
 and L2 cache ECC
References: <20171110090308.21562-1-jlu@pengutronix.de>
 <20171110090308.21562-8-jlu@pengutronix.de>
Message-ID: <fa56e3ae558e412bb1d25da3557d3ba6@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/17 22:03, Jan Luebbe wrote:
> +static const struct of_device_id armada_xp_mc_edac_of_match[] = {
> +	{.compatible = "marvell,armada-xp-sdram-controller",},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, armada_xp_mc_edac_of_match);

FYI I've also found that Armada-370 and Armada-38x will be compatible 
with this driver (as well as the 98dx3236 I mentioned on the initial 
series). Again the difference is that all of these have a 32-bit DDR 
interface. Also in the interim I've got my hands on a custom Armada-38x 
board with ECC.

Once this lands I'll re-send my follow up patches. To add support for 
these SoCs.
