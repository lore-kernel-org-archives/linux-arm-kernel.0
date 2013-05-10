From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 10 May 2013 08:41:38 -0400 (EDT)
Subject: [PATCH 1/1] ARM: mcpm: Fix build error with gic_secondary_init
 call
In-Reply-To: <1368166526-12525-1-git-send-email-sachin.kamat@linaro.org>
References: <1368166526-12525-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <alpine.LFD.2.03.1305100840390.13109@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 May 2013, Sachin Kamat wrote:

> Commit c0114709ed ("irqchip: gic: Perform the gic_secondary_init()
> call via CPU notifier") removed all platform calls to gic_secondary_init.
> Since this file got merged after the removal of the above call, this
> function got left out in the current file which is causing the following
> build error:
> arch/arm/common/mcpm_platsmp.c:52:2: error: implicit declaration of function
> ?gic_secondary_init? [-Werror=implicit-function-declaration]
> gic_secondary_init(0);
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>

I already submitted a patch to fix this:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7715/1


Nicolas
