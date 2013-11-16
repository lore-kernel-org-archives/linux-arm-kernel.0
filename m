From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Nov 2013 09:55:29 +0000
Subject: [PATCH 16/31] ASoC: tegra: use reset framework
In-Reply-To: <1384548866-13141-17-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-17-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131116095529.GF15393@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:11PM -0700, Stephen Warren wrote:

> @@ -1,6 +1,8 @@
>  config SND_SOC_TEGRA
>  	tristate "SoC Audio for the Tegra System-on-Chip"
>  	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
> +	depends on COMMON_CLK
> +	depends on RESET_CONTROLLER

Do you depend on COMMON_CLK here?  I only noticed reset controller API
dependencies here but perhaps I missed this (or it's fixing a dependency
that should be there already).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/ec20f9ff/attachment.sig>
