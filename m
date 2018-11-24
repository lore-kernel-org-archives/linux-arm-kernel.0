From: vkoul@kernel.org (Vinod Koul)
Date: Sat, 24 Nov 2018 19:11:55 +0530
Subject: [PATCH] dmaengine: xilinx_dma: Remove __aligned attribute on
 zynqmp_dma_desc_ll
In-Reply-To: <20181025180525.28378-1-natechancellor@gmail.com>
References: <20181025180525.28378-1-natechancellor@gmail.com>
Message-ID: <20181124134155.GC3175@vkoul-mobl.Dlink>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-10-18, 11:05, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/dma/xilinx/zynqmp_dma.c:166:4: warning: attribute 'aligned' is
> ignored, place it after "struct" to apply attribute to type declaration
> [-Wignored-attributes]
> }; __aligned(64)
>    ^
> ./include/linux/compiler_types.h:200:38: note: expanded from macro
> '__aligned'
> #define __aligned(x)            __attribute__((aligned(x)))
>                                                ^
> 1 warning generated.
> 
> As Nick pointed out in the previous version of this patch, the author
> likely intended for this struct to be 8-byte (64-bit) aligned, not
> 64-byte, which is the default. Remove the hanging __aligned attribute.

Applied, thanks

-- 
~Vinod
