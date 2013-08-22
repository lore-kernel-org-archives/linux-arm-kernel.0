From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Aug 2013 12:54:51 +0100
Subject: [PATCH 1/1] ARM: at91: sam9g45: shutdown ddr1 too when rebooting
In-Reply-To: <1377169244-20462-1-git-send-email-plagnioj@jcrosoft.com>
References: <1377169244-20462-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20130822115451.GH6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 01:00:44PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> diff --git a/arch/arm/mach-at91/at91sam9g45_reset.S b/arch/arm/mach-at91/at91sam9g45_reset.S
> index 721a1a3..3fd634d 100644
> --- a/arch/arm/mach-at91/at91sam9g45_reset.S
> +++ b/arch/arm/mach-at91/at91sam9g45_reset.S
> @@ -21,6 +21,8 @@
>  at91sam9g45_restart:
>  			ldr	r5, =at91_ramc_base		@ preload constants
>  			ldr	r0, [r5]
> +			add	r5, #4				@ ddr1
> +			ldr	r5, [r5]

I know this isn't critical code, but is there any reason why you can't
use:

			ldr	r5, [r5, #4]

here?
