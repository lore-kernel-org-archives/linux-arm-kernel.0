From: manuel.lauss@gmail.com (Manuel Lauss)
Date: Wed, 2 Mar 2016 07:50:28 +0100
Subject: [PATCH] pcmcia: db1xxx: use correct irq_to_gpio helper
In-Reply-To: <1547427.xN2rd1Mon4@wuerfel>
References: <1547427.xN2rd1Mon4@wuerfel>
Message-ID: <CAOLZvyHH4-uq_fnpjrRptkMfjR1+1kzxXM+AUtj_Zb5V3AL-yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Arnd,


On Tue, Mar 1, 2016 at 11:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> After the removal of asm/gpio.h and asm/mach-au1x00/gpio.h, the db1xxx_ss
> pcmcia driver picked up the wrong irq_to_gpio function from the generic
> headers.
>
> This restores the old __au_irq_to_gpio() implementation, but keeps
> it local to the only file that uses it.
>
> It would be nicer to just pass the gpio number from platform code,
> but restoring the previous implementation seems safer.

Give me a few hours and I'll fix this driver for good.


> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable at vger.kernel.org # v4.3
> Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
> ---
> I think this is now the last holdout of the irq_to_gpio function,
> and it's been broken for a while. Maybe Ralf can queue it up through
> the MIPS tree along with the other fix for irq_to_gpio?

It's not broken though..  this driver on current linus-git works fine!

Thank you,
      Manuel
