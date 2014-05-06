From: loeliger@gmail.com (Jon Loeliger)
Date: Tue, 6 May 2014 10:23:16 -0500
Subject: [PATCH] irqchip: sirf: fix 'line over 80 characters'
In-Reply-To: <1399388316-19465-1-git-send-email-21cnbao@gmail.com>
References: <1399388316-19465-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CAJgR-BikPVzi1bKpBwk-vvrDv9cwFgjWcg-NmH8SKsEOWDnxcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> fix "line line over 80 characters" for the below:
> static int __init sirfsoc_irq_init(struct device_node *np, struct device_node *parent)
>
> the users of the codes - key customers really care about that.

And readers of the Linux logs - key developers really care about snark.

jdl

On Tue, May 6, 2014 at 9:58 AM, Barry Song <21cnbao@gmail.com> wrote:
> From: Bin Shi <Bin.Shi@csr.com>
>
> fix "line line over 80 characters" for the below:
> static int __init sirfsoc_irq_init(struct device_node *np, struct device_node *parent)
>
> the users of the codes - key customers really care about that.
>
> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/irqchip/irq-sirfsoc.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sirfsoc.c b/drivers/irqchip/irq-sirfsoc.c
> index 581eefe..5e54f6d 100644
> --- a/drivers/irqchip/irq-sirfsoc.c
> +++ b/drivers/irqchip/irq-sirfsoc.c
> @@ -58,7 +58,8 @@ static void __exception_irq_entry sirfsoc_handle_irq(struct pt_regs *regs)
>         handle_IRQ(irqnr, regs);
>  }
>
> -static int __init sirfsoc_irq_init(struct device_node *np, struct device_node *parent)
> +static int __init sirfsoc_irq_init(struct device_node *np,
> +       struct device_node *parent)
>  {
>         void __iomem *base = of_iomap(np, 0);
>         if (!base)
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
