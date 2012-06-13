From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Jun 2012 10:38:26 +0200
Subject: [PATCH 2/3] clk: add ICST307 driver
In-Reply-To: <20120612230630.GK19410@gmail.com>
References: <1339429196-32584-1-git-send-email-linus.walleij@linaro.org>
 <20120612230630.GK19410@gmail.com>
Message-ID: <CACRpkdYvLEkuFLPCAT15jpqfML_tDwXuR6kENZbwMDaWpunrxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 1:06 AM, Mike Turquette <mturquette@ti.com> wrote:
> On 20120611-17:39, Linus Walleij wrote:

>> +obj-$(CONFIG_CLK_ICST) ? ? ? ? ? ? ? += clk-icst.o
>
> Is there a better place to put this than the top-level directory?

I can put it alone in a subdirectory if you want to... It is used only
by the ARM reference designs AFAICT, shall I put these Integrator
things into clk/versatile as we use the "versatile" name to refer to all
ARM reference designs (i.e. arch/arm/plat-versatile).

>> +struct clk * __init icst_clk_init(struct device *dev, const struct clk_icst_desc *desc)
>
> Nitpick: icst_clk_init should be renamed icst_clk_register to more
> closely resemble other clock registration functions which allocate
> memory dynamically.

I'll fix!

Yours,
Linus Walleij
