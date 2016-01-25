From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 25 Jan 2016 11:32:51 +0100
Subject: [PATCH] ARM64: rk3368: add tuning clk for emmc and sdmmc
In-Reply-To: <1453707223-28855-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453707223-28855-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <8282572.0k5rjtDfQ3@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Montag, 25. Januar 2016, 15:33:43 schrieb Shawn Lin:
> Add tuning clk for emmc and sdmmc, otherwise I get
> the following failure while enabling mmc-hs200-1_8v.
> 
> dwmmc_rockchip ff0f0000.dwmmc: Tuning clock (sample_clk) not defined.
> mmc0: tuning execution failed
> mmc0: error -5 whilst initialising MMC card
> 
> With it
> dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase to 170
> mmc0: new HS200 MMC card at address 0001
> mmcblk0: mmc0:0001 M8G1GC 7.28 GiB
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

applied to my dts64 branch for 4.6

I've adapted the subject to
	arm64: dts: rockchip: add rk3368 tuning clk for emmc and sdmmc
to follow the format used there (it doesn't seem 100% consistent between socs)


>  		clock-freq-min-max = <400000 150000000>;
>  		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
>  		clock-names = "biu", "ciu";
> +		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
> +			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
> +		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
>  		fifo-depth = <0x100>;
>  		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
>  		status = "disabled";

I've also removed the duplicate clock entry here ;-)


Heiko
