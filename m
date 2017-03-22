From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 22 Mar 2017 20:45:51 +0200
Subject: [PATCH 1/2] tty: serial_core: Add name field to uart_port struct
In-Reply-To: <20170321133636.8814-2-vigneshr@ti.com>
References: <20170321133636.8814-1-vigneshr@ti.com>
 <20170321133636.8814-2-vigneshr@ti.com>
Message-ID: <CAHp75VfHtTV6L0GE61kMiHMCQrUSwGJPRxsiNuOCD9mY7MPpZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 3:36 PM, Vignesh R <vigneshr@ti.com> wrote:
> Introduce a field to store name of uart_port that can be used to easily
> identify uart port instances on a system that has more than one uart

uart -> UART

> instance. The name is of the form ttyXN(eg. ttyS0, ttyAMA0,..) where N
> is number that particular uart instance.
> This field will be useful when printing debug info for a particular port
> or in register irqs with unique irq name. Port name is populated during

irq(s) -> IRQ(s)

> uart_add_one_port().

> +       snprintf(uport->name, sizeof(uport->name), "%s%d", drv->dev_name,
> +                drv->tty_driver->name_base + uport->line);

This is fragile. dev_name is defined as pointer, so, it would be any length.
So, better to use [devm_]kasprintf().

-- 
With Best Regards,
Andy Shevchenko
