From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Oct 2016 15:19:56 +0100
Subject: [PATCH] ASoC: hdmi-codec: Fix hdmi_of_xlate_dai_name when
 #sound-dai-cells = <0>
In-Reply-To: <1477568568.2908.14.camel@linaro.org>
References: <1477568568.2908.14.camel@linaro.org>
Message-ID: <20161027141956.GL25322@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 12:42:48PM +0100, Jon Medhurst (Tixy) wrote:

> -	int id = args->args[0];
> +	int id = args->args_count ? args->args[0] : 0;

Please write normal if statements for legibility.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/35ec96ca/attachment.sig>
