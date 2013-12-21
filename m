From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Sat, 21 Dec 2013 13:50:56 +0530
Subject: [PATCH v2 1/2] gpio: davinci: don't create irq_domain in case of
 unbanked irqs
In-Reply-To: <1387361272-20861-2-git-send-email-grygorii.strashko@ti.com>
References: <1387361272-20861-1-git-send-email-grygorii.strashko@ti.com>
 <1387361272-20861-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <CA+V-a8tBQPAHjHibLa=n1mu31ZJyLU3vGwLutHqe=Fg4eXq6zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 3:37 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> The system may crash if:
> - there are more then 1 bank
> - unbanked irqs are enabled
> - someone will call gpio_to_irq() for GPIO from bank2 or above
>
> Hence, fix it by not creating irq_domain if unbanked irqs are enabled
> and correct gpio_to_irq_banked() to handle this properly.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
--Prabhakar Lad
