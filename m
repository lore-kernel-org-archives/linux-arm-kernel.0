From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 May 2014 12:08:42 -0700
Subject: [PATCH 11/15] ASoC: WM0010 needs SPI
In-Reply-To: <1398770316-19715-12-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-12-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20140501190842.GZ3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 07:18:32PM +0800, Xia Kaixu wrote:

> @@ -201,7 +201,7 @@ config SND_SOC_SPEYSIDE
>  	select SND_SAMSUNG_I2S
>  	select SND_SOC_WM8996
>  	select SND_SOC_WM9081
> -	select SND_SOC_WM0010
> +	select SND_SOC_WM0010 if SPI
>  	select SND_SOC_WM1250_EV1

No, this is broken.  The driver won't work if all the components it uses
don't load and the dependency for SPI isn't SPI, it's SPI_MASTER.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140501/7b3f6f04/attachment.sig>
