From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 Feb 2017 10:47:34 -0800
Subject: [PATCH v2 4/8] sound: soc: pxa: Suppress SND_MMP_SOC for arm64
In-Reply-To: <20170222022929.10540-5-afaerber@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
 <20170222022929.10540-5-afaerber@suse.de>
Message-ID: <20170222184734.wmkbzfsz4yklofcg@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 03:29:24AM +0100, Andreas F?rber wrote:

This is patch 4 of 8, what's going on with dependencies here?

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

>  config SND_MMP_SOC
> -	bool "Soc Audio for Marvell MMP chips"
> -	depends on ARCH_MMP
> +	bool "SoC Audio for Marvell MMP chips"
> +	depends on ARCH_MMP && ARM

There are no obvious build time architecture dependencies for this
driver, shouldn't we have an || COMPILE_TEST in here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170222/308175b4/attachment.sig>
