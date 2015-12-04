From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 16:54:40 -0800
Subject: [PATCH v2 13/14] ARM: DTS: am33xx: Use the new DT bindings for
 the eDMA3
In-Reply-To: <1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
 <1444979892-31626-14-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20151204005440.GE23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151016 00:23]:

I noticed something while changing dm81xx to use the edma_xbar..

> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> +
> +		edma_xbar: dma-router at 44e10f90 {
> +			compatible = "ti,am335x-edma-crossbar";
> +			reg = <0x44e10f90 0x40>;
> +
> +			#dma-cells = <3>;
> +			dma-requests = <32>;
> +
> +			dma-masters = <&edma>;
>  		};

The edma_xbar should now be just a child at offset 0xf90 under the
scm: scm at 210000. Can you please check the other patches too?

Regards,

Tony
