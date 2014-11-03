From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 3 Nov 2014 14:35:50 -0200
Subject: [PATCH] mfd: db8500-prcmu: Provide sane error path values
In-Reply-To: <1415031356-11664-1-git-send-email-lee.jones@linaro.org>
References: <1415031356-11664-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAOMZO5C2sB1GNuNE-Bi5jqMO4DqBcDW2C1O+asYkbW=8fXA7TA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 3, 2014 at 2:15 PM, Lee Jones <lee.jones@linaro.org> wrote:

>         /* Clean up the mailbox interrupts after pre-kernel code. */
> @@ -3179,15 +3179,14 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
>         irq = platform_get_irq(pdev, 0);
>         if (irq <= 0) {

Shouldn't this be if (irq < 0) then?

>                 dev_err(&pdev->dev, "no prcmu irq provided\n");
> -               return -ENOENT;
> +               return irq;
