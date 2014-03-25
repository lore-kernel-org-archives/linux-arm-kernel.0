From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Mar 2014 11:27:16 +0000
Subject: [RFC v2 PATCH] ASoC: wm8904: add CCF support
In-Reply-To: <1395741416-23981-1-git-send-email-voice.shen@atmel.com>
References: <1395741416-23981-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20140325112716.GS2269@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 05:56:56PM +0800, Bo Shen wrote:

>  	case SND_SOC_BIAS_ON:
> +		if (IS_ENABLED(CONFIG_COMMON_CLK))
> +			if (wm8904->mclk)
> +				clk_prepare_enable(wm8904->mclk);

No, this shouldn't depend on COMMON_CLK - there is no reason other clock
API implementations shouldn't be able to use this.  Providing a clock is
something you can only do with COMMON_CLK but using one doesn't need
that, generally using a clock is done unconditionally.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140325/7949b8d6/attachment.sig>
