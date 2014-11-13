From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Nov 2014 17:49:05 +0100
Subject: [PATCH] dmaengine: pl330: Fix linker error "undefined reference
 to `__aeabi_uldivmod'"
In-Reply-To: <1415896047.1787.4.camel@linaro.org>
References: <1415896047.1787.4.camel@linaro.org>
Message-ID: <1799482.v2vqT9blFd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 16:27:27 Jon Medhurst wrote:
> 32-bit ARM kernels may have a 64-bit dma_addr_t but have no
> implementation of the compiler helper for 64-bit unsigned division,
> therefore the use of the modulo operator in pl330_prep_dma_memcpy causes
> the link error "undefined reference to `__aeabi_uldivmod'"
> 
> As the burst value is always a power of two we can fix the problem, and
> make the code more efficient, by replacing "% burst" with "& (burst-1)".
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> 

Just saw the same thing and was going to send a different patch, but
yours is better.

Acked-by: Arnd Bergmann <arnd@arndb.de>
