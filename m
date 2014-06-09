From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Jun 2014 15:21:15 +0200
Subject: [PATCH v2 1/5] pinctrl: sunxi: Fix sunxi_irq_cfg_reg not working
 for irqs >= 8
In-Reply-To: <20140602101808.GB27722@lukather>
References: <1401544899-405-1-git-send-email-hdegoede@redhat.com>
 <1401544899-405-2-git-send-email-hdegoede@redhat.com>
 <20140602101808.GB27722@lukather>
Message-ID: <CACRpkdZ=jmj_ioob6EPM1GXKt-nfLiebnMeLwW7skuJtA3hCTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 2, 2014 at 12:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, May 31, 2014 at 04:01:35PM +0200, Hans de Goede wrote:
>> Rename SUNXI_IRQ_NUMBER to IRQ_PER_BANK as it no longer represents the total
>> number of irqs and use it instead of the number of irqs-per-reg when
>> calculating the bank to use for the various sunxi_irq_xxx_reg functions.
>> This fixes sunxi_irq_cfg_reg using the wrong bank for irqs >= 8.
>>
>> Also sunxi_irq_cfg_reg_from_bank returns the address of pio_int_cfg0, add an
>> offset to the register returned for irqs living in the pio_int_cfg[1-3].
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Good catch, I've squashed it into my serie with minor modifications
> (remove the cfg_reg_from_bank that doesn't make any sense).

I'm more than a little confused by your and Hans parallell patch
series to sunxi now :-)

I will try to apply your patches first, then Hans' as you're the
maintainer of this driver.

Yours,
Linus Walleij
