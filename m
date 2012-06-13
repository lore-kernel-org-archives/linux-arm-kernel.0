From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 13 Jun 2012 07:42:21 -0700
Subject: [PATCH 2/3] clk: add ICST307 driver
In-Reply-To: <CACRpkdYvLEkuFLPCAT15jpqfML_tDwXuR6kENZbwMDaWpunrxQ@mail.gmail.com>
References: <1339429196-32584-1-git-send-email-linus.walleij@linaro.org>
 <20120612230630.GK19410@gmail.com>
 <CACRpkdYvLEkuFLPCAT15jpqfML_tDwXuR6kENZbwMDaWpunrxQ@mail.gmail.com>
Message-ID: <CAJOA=zPfDUgK=QGU62PYUqfhV4YqTTYVs+7-w=wVTeQTNeUdzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 1:38 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jun 13, 2012 at 1:06 AM, Mike Turquette <mturquette@ti.com> wrote:
>> On 20120611-17:39, Linus Walleij wrote:
>
>>> +obj-$(CONFIG_CLK_ICST) ? ? ? ? ? ? ? += clk-icst.o
>>
>> Is there a better place to put this than the top-level directory?
>
> I can put it alone in a subdirectory if you want to... It is used only
> by the ARM reference designs AFAICT, shall I put these Integrator
> things into clk/versatile as we use the "versatile" name to refer to all
> ARM reference designs (i.e. arch/arm/plat-versatile).
>

drivers/clk/versatile seems sensible.  I am just trying to prevent
drivers/clk/ becoming very messy.  If other platforms are going to use
this code then the top-level location makes sense, otherwise lets use
drivers/clk/versatile.

>>> +struct clk * __init icst_clk_init(struct device *dev, const struct clk_icst_desc *desc)
>>
>> Nitpick: icst_clk_init should be renamed icst_clk_register to more
>> closely resemble other clock registration functions which allocate
>> memory dynamically.
>
> I'll fix!
>

Thanks!
Mike

> Yours,
> Linus Walleij
