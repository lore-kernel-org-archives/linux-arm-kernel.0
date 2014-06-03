From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Jun 2014 13:21:09 +0200
Subject: [PATCH-next] mfd: ab8500: fix dt irq mapping
In-Reply-To: <1401726478-14879-1-git-send-email-grygorii.strashko@ti.com>
References: <1401726478-14879-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <CACRpkda7EEJNmfjHseQP9ChQ+OJf62qe=aBy3FJ-EFPGO1r6cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 2, 2014 at 6:27 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> The AD8500 defines itself as interrupt-controller in DT,
> but it doesn't assign DT node to IRQ domain when creates it.
> As result, of_irq_xx() helpers don't work because they can't
> find necessary IRQ domain.
>
> Hence, fix it by assigning AD8500 core device DT node to IRQ
> domain when it's created.
>
> This patch fixes STE u8500 Snowball boot failure reported by Kevin Hilman
> https://lkml.org/lkml/2014/5/27/624
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Reported-and-tested-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
