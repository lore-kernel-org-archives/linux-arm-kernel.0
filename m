From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Jan 2015 09:37:11 +0100
Subject: [PATCH 3/4] arm64: dts: Add APM X-Gene PCIe DMA device tree nodes
In-Reply-To: <1420608537-12296-4-git-send-email-mchitale@apm.com>
References: <1420608537-12296-1-git-send-email-mchitale@apm.com>
 <1420608537-12296-4-git-send-email-mchitale@apm.com>
Message-ID: <6884775.IcL8KCPQhi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 January 2015 10:58:56 Mayuresh Chitale wrote:
> 
> +               xpdma0: dma0 at 1f2b0154 {
> +                       status = "disabled";
> +                       compatible = "apm,xgene-pciedma";
> +                       reg = < 0x0 0x1f2b0154 0x0 0xc
> +                               0x0 0x1f2b0058 0x0 0x8>;
> +                       interrupts = <0x0 0xc6 0x4>;
> +               };
> +
> +               xpdma1: dma1 at 1f2c0154 {
> +                       status = "disabled";
> +                       compatible = "apm,xgene-pciedma";
> +                       reg = < 0x0 0x1f2c0154 0x0 0xc
> +                               0x0 0x1f2c0058 0x0 0x8>;
> +                       interrupts = <0x0 0xcc 0x4>;
> +               };
> +
> 

Something's wrong here: you have the same addresses for
all the nodes but use different names. Please change the names
to all say 'dma' and set the correct addresses.

	Arnd
