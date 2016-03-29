From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 10:11:33 +0200
Subject: [PATCH 2/2] ARM: uniphier: initialize outer cache for secondary
 CPUs
In-Reply-To: <201603291505.HKmOMR4P%fengguang.wu@intel.com>
References: <201603291505.HKmOMR4P%fengguang.wu@intel.com>
Message-ID: <3226381.VKfgCFa2AC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 15:59:00 kbuild test robot wrote:
> 
> All warnings (new ones prefixed by >>):
> 
> >> WARNING: vmlinux.o(.text+0x557b4): Section mismatch in reference from the function uniphier_cache_secondary_init() to the function .init.text:uniphier_cache_activate_all_ways()
>    The function uniphier_cache_secondary_init() references
>    the function __init uniphier_cache_activate_all_ways().
>    This is often because uniphier_cache_secondary_init lacks a __init
>    annotation or the annotation of uniphier_cache_activate_all_ways is wrong.
> 


I guess the former: uniphier_cache_secondary_init should be __init, as it will
only be run at boot time.

Please resend both patches.

	Arnd
