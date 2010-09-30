From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 30 Sep 2010 09:19:20 +0200
Subject: [PATCH 2/4] arm: dis-allow hotplug on MSM
In-Reply-To: <1284062289-10914-3-git-send-email-dwalker@codeaurora.org>
References: <1284062289-10914-1-git-send-email-dwalker@codeaurora.org>
	<1284062289-10914-3-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100930071919.GA6434@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> MSM doesn't support hotplug, so we prevent it from being
> select with this added line.
> 
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d2dfbc2..829dd67 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1211,6 +1211,7 @@ config NR_CPUS
>  config HOTPLUG_CPU
>  	bool "Support for hot-pluggable CPUs (EXPERIMENTAL)"
>  	depends on SMP && HOTPLUG && EXPERIMENTAL
> +	depends on !ARCH_MSM
>  	help
>  	  Say Y here to experiment with turning CPUs off and on.  CPUs
>  	  can be controlled through /sys/devices/system/cpu.

This is goodbye to s2ram support, AFAICT.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
