From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Sep 2017 10:20:19 +0200
Subject: [PATCH] nvmem: sunxi-sid: add support for A64/H5's SID controller
In-Reply-To: <20170918154204.54427-1-icenowy@aosc.io>
References: <20170918154204.54427-1-icenowy@aosc.io>
Message-ID: <20170919082019.6bopwauso4mbslqo@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 11:42:04PM +0800, Icenowy Zheng wrote:
> Allwinner A64/H5 SoCs come with a SID controller like the one in H3, but
> without the silicon bug that makes the initial value at 0x200 wrong, so
> the value at 0x200 can be directly read.
> 
> Add support for this kind of SID controller.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
>  drivers/nvmem/sunxi_sid.c                                       | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> index ef06d061913c..6ea0836939ee 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> @@ -5,6 +5,7 @@ Required properties:
>    "allwinner,sun4i-a10-sid"
>    "allwinner,sun7i-a20-sid"
>    "allwinner,sun8i-h3-sid"
> +  "allwinner,sun50i-a64-sid"
>  
>  - reg: Should contain registers location and length
>  
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index 0d6648be93b8..3c9fd4fb9207 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -199,10 +199,16 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
>  	.need_register_readout = true,
>  };
>  
> +static const struct sunxi_sid_cfg sun50i_a64_cfg = {
> +	.value_offset = 0x200,
> +	.size = 0x100,
> +};
> +

How did you get those values?

Also, it's reported that the SID can only be accessed in secure mode,
did you test it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170919/fed1212f/attachment.sig>
