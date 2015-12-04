From: balbi@ti.com (Felipe Balbi)
Date: Fri, 4 Dec 2015 11:21:49 -0600
Subject: [PATCH] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
In-Reply-To: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449225915-28879-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <87wpsunn82.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> @@ -174,12 +182,44 @@
>  		};
>  
>  		edma: edma at 49000000 {
> -			compatible = "ti,edma3";
> -			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> -			reg =	<0x49000000 0x10000>,
> -				<0x44e10f90 0x40>;
> +			compatible = "ti,edma3-tpcc";
> +			ti,hwmods = "tpcc";
> +			reg =	<0x49000000 0x10000>;
> +			reg-names = "edma3_cc";
>  			interrupts = <12 13 14>;
> -			#dma-cells = <1>;
> +			interrupt-names = "edma3_ccint", "emda3_mperr",
> +					  "edma3_ccerrint";
> +			dma-requests = <64>;
> +			#dma-cells = <2>;
> +
> +			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
> +				   <&edma_tptc2 0>;
> +
> +			ti,edma-memcpy-channels = /bits/ 16 <20 21>;

can you explain this property here ? Are you setting bits 20 and 21 on a
16-bit field ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151204/a4ae2f4a/attachment-0001.sig>
