From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Feb 2014 13:32:35 -0700
Subject: [PATCH 3/9] ARM: select MIGHT_HAVE_CACHE_L2X0 for V7
 multi-platform
In-Reply-To: <1392153119-23248-4-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-4-git-send-email-robherring2@gmail.com>
Message-ID: <52FBDA63.6030303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2014 02:11 PM, Rob Herring wrote:
> Many V7 platforms have an L2x0 cache, so make CONFIG_MIGHT_HAVE_CACHE_L2X0
> visible for V7 multi-platform builds.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig

>  config ARCH_MULTI_V6_V7
>  	bool
> +	select MIGHT_HAVE_CACHE_L2X0

The commit description says "V7", whereas the select got added to
"V6_V7" rather then "V7". Was that intentional?
