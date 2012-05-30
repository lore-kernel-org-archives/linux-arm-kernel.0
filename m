From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 15:10:28 +0800
Subject: [PATCH 16/22] mfd: ab8500-gpadc: Enable IRQF_ONESHOT when
 requesting a threaded IRQ
In-Reply-To: <1338353260-10097-17-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-17-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYZaxW52dWwGzEo-7yV31dW_U37xUP2TM4G+Dz=dJ8EKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The kernel now forces IRQs to be ONESHOT if no IRQ handler is passed.
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> ?drivers/mfd/ab8500-gpadc.c | ? ?3 ++-
> ?1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
> index c39fc71..358d502 100644
> --- a/drivers/mfd/ab8500-gpadc.c
> +++ b/drivers/mfd/ab8500-gpadc.c
> @@ -599,7 +599,8 @@ static int __devinit ab8500_gpadc_probe(struct platform_device *pdev)
> ? ? ? ?/* Register interrupt ?- SwAdcComplete */
> ? ? ? ?ret = request_threaded_irq(gpadc->irq, NULL,
> ? ? ? ? ? ? ? ?ab8500_bm_gpswadcconvend_handler,
> - ? ? ? ? ? ? ? IRQF_NO_SUSPEND | IRQF_SHARED, "ab8500-gpadc", gpadc);
> + ? ? ? ? ? ? ? IRQF_ONESHOT | IRQF_NO_SUSPEND | IRQF_SHARED,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "ab8500-gpadc", gpadc);

Looks correct to me I think this one should be ONESHOT anyway.

Yours,
Linus Walleij
