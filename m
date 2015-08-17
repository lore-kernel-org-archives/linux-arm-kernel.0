From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Aug 2015 11:11:17 +0200
Subject: [PATCH v4 1/6] mfd: fsl imx25 Touchscreen ADC driver
In-Reply-To: <CACRpkdbFcgK69yakt+XYOg2q_QT8R263+FrADzz=r+fYNEFPSg@mail.gmail.com>
References: <1403621185-9581-1-git-send-email-denis@eukrea.com>
 <CACRpkdbFcgK69yakt+XYOg2q_QT8R263+FrADzz=r+fYNEFPSg@mail.gmail.com>
Message-ID: <CACRpkda9LTxmOBXyGDUuhMej4W_waJwYkmay4ELYmQ1zJstSRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 11:18 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Jun 24, 2014 at 4:46 PM, Denis Carikli <denis@eukrea.com> wrote:

>> +       irq_set_chip_and_handler(irq, &dummy_irq_chip,
>> +                                handle_level_irq);
>> +       set_irq_flags(irq, IRQF_VALID);
>
> This function only exists on ARM. Unless Kconfig ensures
> this is only available on ARM platforms, use
>
> #ifdef CONFIG_ARM
>       set_irq_flags(irq, IRQF_VALID);
> #else
>       irq_set_noprobe(irq);
> #endif
>
> (Sorry we have no better way of doing it.)

Since I wrote this, there have been cleanups from Rob Herring merged
to the kernel to get rid of this oddity. Please check in linux-next how
to get this right, see c.f. commit
e8d36d5dbb6a6ec4f5222f8775d664ec29d5527d
"ARM: kill off set_irq_flags usage"

Yours,
Linus Walleij
