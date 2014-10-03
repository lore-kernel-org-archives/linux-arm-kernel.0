From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Oct 2014 13:49:56 +0100
Subject: [PATCH v2 3/6] dtb: Add 10GbE node to APM X-Gene SoC device tree
In-Reply-To: <1412294568-26747-4-git-send-email-isubramanian@apm.com>
References: <1412294568-26747-1-git-send-email-isubramanian@apm.com>
 <1412294568-26747-4-git-send-email-isubramanian@apm.com>
Message-ID: <20141003124956.GI26643@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[...]

> +		xgenet: ethernet at 1f610000 {
> +			compatible = "apm,xgene-enet";
> +			status = "disabled";
> +			reg = <0x0 0x1f610000 0x0 0xd100>,
> +			      <0x0 0x1f600000 0x0 0X400>,
> +			      <0x0 0x18000000 0x0 0X200>;
> +			reg-names = "enet_csr", "ring_csr", "ring_cmd";
> +			interrupts = <0x0 0x60 0x4>;
> +			dma-coherent;
> +			clocks = <&xge0clk 0>;
> +			local-mac-address = [00 01 73 00 00 04];

Apolgoies, I'd missed your reply on this last time. Please use
all-zeroes for the mac address, and have a comment that this will be
overwritten by the bootloader.

Thanks,
Mark.
