From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Apr 2016 16:49:33 +0100
Subject: [PATCH 10/18] ASoC: sti: Update example to include
 assigned-clocks and mclk-fs
In-Reply-To: <1461236675-10176-11-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-11-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160421154933.GR3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 12:04:27PM +0100, Peter Griffin wrote:

>  		clocks = <&clk_s_d0_flexgen CLK_PCM_2>;
> +		assigned-clocks = <&clk_s_d0_flexgen CLK_PCM_2>;
> +		assigned-clock-parents = <&clk_s_d0_quadfs 2>;
> +		assigned-clock-rates = <50000000>;

This may be true for the particular system you're looking at but isn't
really relevant to the device.

> @@ -133,6 +139,7 @@ Example of audio card declaration:
>  			/* DAC */
>  			format = "i2s";
>  			dai-tdm-slot-width = <32>;
> +			mclk-fs = <256>;
>  			cpu {
>  				sound-dai = <&sti_uni_player2>;
>  			};

This one is more relevant though I'm still a bit concerned that there's
an expectation that the examples can just be pasted in...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160421/7c8ea534/attachment.sig>
