From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Nov 2018 10:00:50 -0800
Subject: [PATCH] ARM: OMAP2+: prm44xx: Fix section annotation on
 omap44xx_prm_enable_io_wakeup
In-Reply-To: <20181018005400.7521-1-natechancellor@gmail.com>
References: <20181018005400.7521-1-natechancellor@gmail.com>
Message-ID: <20181119180050.GS53235@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nathan Chancellor <natechancellor@gmail.com> [181017 17:54]:
> When building the kernel with Clang, the following section mismatch
> warning appears:
> 
> WARNING: vmlinux.o(.text+0x38b3c): Section mismatch in reference from
> the function omap44xx_prm_late_init() to the function
> .init.text:omap44xx_prm_enable_io_wakeup()
> The function omap44xx_prm_late_init() references
> the function __init omap44xx_prm_enable_io_wakeup().
> This is often because omap44xx_prm_late_init lacks a __init
> annotation or the annotation of omap44xx_prm_enable_io_wakeup is wrong.
> 
> Remove the __init annotation from omap44xx_prm_enable_io_wakeup so there
> is no more mismatch.

Applying into omap-for-v4.21/soc thanks.

Tony
