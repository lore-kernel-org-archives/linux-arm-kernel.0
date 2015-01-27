From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Jan 2015 21:13:51 +0100
Subject: [PATCH v1 2/2] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
In-Reply-To: <1422379260-10139-3-git-send-email-stripathi@apm.com>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <1422379260-10139-3-git-send-email-stripathi@apm.com>
Message-ID: <4747424.udeKOcy6tC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 January 2015 22:51:00 Suman Tripathi wrote:
> 
> +               sdhc0: sdhc at 1c000000 {
> +                       device_type = "sdhc";
> +                       compatible = "arasan,sdhci-8.9a";
> +                       reg = <0x0 0x1c000000 0x0 0x100>;
> +                       interrupts = <0x0 0x49 0x4>;
> +                       clock-names = "clk_xin", "clk_ahb";
> +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
> +               };
> +

Here you don't provide an 'iommus' property, which means that the
device is unable to use the iommu.

	Arnd
