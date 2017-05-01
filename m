From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 May 2017 18:05:53 +0200
Subject: [PATCH v3 4/5] ARM: sun7i: Convert to CCU
In-Reply-To: <560676328328d23f344468f5c43ff1b1533f36f0.1493235134.git-series.plaes@plaes.org>
References: <cover.908ce010a25e503bb5ad0967759c723219c6ed0d.1493235134.git-series.plaes@plaes.org>
 <560676328328d23f344468f5c43ff1b1533f36f0.1493235134.git-series.plaes@plaes.org>
Message-ID: <20170501160553.fa67agqy5ltpwo7p@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 26, 2017 at 10:32:24PM +0300, Priit Laes wrote:
>  			compatible = "allwinner,simple-framebuffer",
>  				     "simple-framebuffer";
>  			allwinner,pipeline = "de_be0-lcd0-hdmi";
> -			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
> -				 <&ahb_gates 44>, <&de_be0_clk>,
> -				 <&tcon0_ch1_clk>, <&dram_gates 26>;
> +			clocks = <&ccu CLK_AHB_LCD0>, <&ccu CLK_AHB_HDMI0>,
> +				 <&ccu CLK_AHB_DE_BE0>, <&ccu CLK_DE_BE0>,
> +				 <&ccu CLK_TCON0_CH1>, <&ccu CLK_DRAM_DE_BE0>,
> +				 <&ccu CLK_HDMI>;

In order to make merging those patches *much* easier, could you just
use the raw IDs (ie not the defines, but the numbers) for now?

And ideally, send a patch after 4.13-rc1 that will switch to the
defines.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170501/22a331f8/attachment.sig>
