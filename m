From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 02 Jun 2014 14:56:36 +0200
Subject: [PATCH v2 2/7] ARM: EXYNOS: add support for firmware-assisted
 c15resume
In-Reply-To: <1401712543-14281-3-git-send-email-b.zolnierkie@samsung.com>
References: <1401712543-14281-1-git-send-email-b.zolnierkie@samsung.com>
 <1401712543-14281-3-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <538C7484.9070801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02.06.2014 14:35, Bartlomiej Zolnierkiewicz wrote:
> From: Tomasz Figa <t.figa@samsung.com>
> 
> This change is a preparation for adding secure firmware support to
> EXYNOS cpuidle driver.
> 
> This patch shouldn't cause any functionality changes.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> [bzolnier: splitted out from bigger patch]
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/include/asm/firmware.h | 4 ++++
>  arch/arm/mach-exynos/firmware.c | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
> index c72ec47..70883c7 100644
> --- a/arch/arm/include/asm/firmware.h
> +++ b/arch/arm/include/asm/firmware.h
> @@ -41,6 +41,10 @@ struct firmware_ops {
>  	 * Initializes L2 cache
>  	 */
>  	int (*l2x0_init)(void);
> +	/*
> +	 * Restores coprocessor 15 registers
> +	 */
> +	int (*c15resume)(u32 *regs);

Well, this was just a kind of internal hack, so I'm not sure this is
suitable as a generic firmware operation in mainline.

I'd rather implement this as a part of a wider suspend and resume
firmware operations, where suspend would save values of cp15 registers
and resume would restore them.

Best regards,
Tomasz
