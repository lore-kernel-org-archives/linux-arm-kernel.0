From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Mar 2015 22:21:37 +0100
Subject: [PATCH 01/10] ARM: zx: add basic support of ZTE ZX296702
In-Reply-To: <1426333785-3952-2-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-2-git-send-email-jun.nie@linaro.org>
Message-ID: <21916189.IW6rzVPlyV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 March 2015 19:49:36 Jun Nie wrote:
> @@ -0,0 +1,21 @@
> +config ARCH_ZX
> +       bool "ZTE ZX family" if ARCH_MULTI_V7
> +       help
> +         Support for ZTE ZX-based family of processors. TV
> +         set-top-box processor is supported. More will be
> +         added soon.
> +
> +menu "ZTE ZX options"
> +       depends on ARCH_ZX

Better use a "menuconfig" statement here.

> +config SOC_ZX296702
> +       bool "Enable support for ZX296702 SoC"
> +       select ARM_GIC
> +       select ARM_GLOBAL_TIMER
> +       select HAVE_ARM_SCU if SMP
> +       select HAVE_ARM_TWD if SMP
> +       select MIGHT_HAVE_CACHE_L2X0
> +       help
> +         Support for ZTE ZX296702 SoC which is a dual core CortexA9MP
> +
> +endmenu

MIGHT_HAVE_CACHE_L2X0 is implied by ARCH_MULTI_V7, so you can drop
that here.

	Arnd
