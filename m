From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 10 Aug 2016 11:23:03 +0200
Subject: [PATCH] ARM: S3C24XX: Add dma_mask assignments for DMA devices
In-Reply-To: <1470304572-14937-1-git-send-email-s.nawrocki@samsung.com>
References: <1470304572-14937-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <CAJKOXPfGceFUtb4Z+E4MSCWNfgtd08U=L+avvXvxNw9X_OkKOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 4, 2016 at 11:56 AM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The dma_mask assignments seem to be missed during refactoring
> of arch/arm/mach-s3c24xx. Add them to avoid DMA allocation
> failures. Without this patch sound is broken on s3c24xx
> with errors reported like:
>
> s3c24xx-dma s3c2410-dma.0: coherent DMA mask is unset
> ALSA pcmC0D0p,0:: cannot preallocate for size 524288
> s3c24xx-iis s3c24xx-iis: Failed to get DMA channel capabilities,
> falling back to period counting: -6
> s3c24xx-dma s3c2410-dma.0: coherent DMA mask is unset
> ...
> ALSA pcmC0D0c,0:: cannot preallocate for size 524288
> s3c24xx-iis s3c24xx-iis: Failed to get DMA channel capabilities,
> falling back to period counting: -6
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/mach-s3c24xx/common.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)

Thanks, applied.

BR,
Krzysztof
