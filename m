From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Wed, 27 Apr 2011 10:11:26 +0530
Subject: [PATCH] Trivial: ARM: pxa168: Bug fix - correct UART DMA channels
In-Reply-To: <1294121226-3358-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1294121226-3358-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <4DB79E76.1080402@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 January 2011 11:37 AM, Tanmay Upadhyay wrote:
> According to ARMADA_16x_Software_Manual.pdf, DMA channels for
> UART1 are 19, 20 and DMA channels for UART2 are 21, 22.
>
> It's of little significance for now as the PXA UART driver
> doesn't use DMA as of now.
>
> Signed-off-by: Tanmay Upadhyay<tanmay.upadhyay@einfochips.com>
> ---
>   arch/arm/mach-mmp/pxa168.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index 72b4e76..7564739 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -147,8 +147,8 @@ void pxa168_clear_keypad_wakeup(void)
>   }
>
>   /* on-chip devices */
> -PXA168_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4017000, 0x30, 21, 22);
> -PXA168_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4018000, 0x30, 23, 24);
> +PXA168_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4017000, 0x30, 19, 20);
> +PXA168_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4018000, 0x30, 21, 22);
>   PXA168_DEVICE(twsi0, "pxa2xx-i2c", 0, TWSI0, 0xd4011000, 0x28);
>   PXA168_DEVICE(twsi1, "pxa2xx-i2c", 1, TWSI1, 0xd4025000, 0x28);
>   PXA168_DEVICE(pwm1, "pxa168-pwm", 0, NONE, 0xd401a000, 0x10);
Is there anything wrong with the patch? Any suggestions please?

Thanks,

Tanmay
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110427/93e8c570/attachment-0001.html>
