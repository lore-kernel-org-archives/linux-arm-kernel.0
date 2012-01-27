From: slapin@ossfans.org (Sergey Lapin)
Date: Fri, 27 Jan 2012 07:25:39 -0500
Subject: [PATCH v2] S3C24XX DMA resume regression fix
In-Reply-To: <1327065184-9805-1-git-send-email-dron0gus@gmail.com>
References: <1327065184-9805-1-git-send-email-dron0gus@gmail.com>
Message-ID: <20120127122537.GF2056@build.ihdev.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 05:13:04PM +0400, Gusakov Andrey wrote:
> In commit bb072c3cf21d1c9a5a2eeb5a00679ee7bf39675b
> (Use struct syscore_ops for "core" power management)
> suspend/resume hooks for each DMA channels were replaced with
> hooks that suspend/resume all channels. s3c2410_dma_suspend
> suspends channels from 0 to dma_channels. s3c2410_dma_resume
> resumes channels in reverse order. So pointer should be
> decremented insted of being incremented.
Any news regarding this patch?
> 
> Signed-off-by: Gusakov Andrey <dron0gus@gmail.com>
> ---
>  arch/arm/plat-s3c24xx/dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> v2: updated commit message with original commit summary
> 

All the best,
S.
