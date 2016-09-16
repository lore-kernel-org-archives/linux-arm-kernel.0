From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 16 Sep 2016 12:30:48 +0200
Subject: [PATCH v7 08/11] arm64: dts: r8a7796: add SDHI nodes
In-Reply-To: <1473764228-24768-9-git-send-email-horms+renesas@verge.net.au>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au>
 <1473764228-24768-9-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160916103048.GL1411@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 12:57:05PM +0200, Simon Horman wrote:
> Add SDHI nodes to the DT of the r8a7796 SoC.
> 
> Based on the DT of the r8a7795 SoC.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

If you remove the two lines you removed from H3 already:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> +		sdhi2: sd at ee140000 {
> +			compatible = "renesas,sdhi-r8a7796";
> +			reg = <0 0xee140000 0 0x2000>;
> +			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 312>;
> +			max-frequency = <200000000>;
> +			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
> +			cap-mmc-highspeed;
This one...

> +			status = "disabled";
> +		};
> +
> +		sdhi3: sd at ee160000 {
> +			compatible = "renesas,sdhi-r8a7796";
> +			reg = <0 0xee160000 0 0x2000>;
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 311>;
> +			max-frequency = <200000000>;
> +			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
> +			cap-mmc-highspeed;

... and ditto.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160916/93927e10/attachment.sig>
