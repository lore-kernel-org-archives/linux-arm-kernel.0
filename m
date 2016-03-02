From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 09:58:07 +0100
Subject: [PATCH] pcmcia: db1xxx: use correct irq_to_gpio helper
In-Reply-To: <CAOLZvyHH4-uq_fnpjrRptkMfjR1+1kzxXM+AUtj_Zb5V3AL-yQ@mail.gmail.com>
References: <1547427.xN2rd1Mon4@wuerfel>
 <CAOLZvyHH4-uq_fnpjrRptkMfjR1+1kzxXM+AUtj_Zb5V3AL-yQ@mail.gmail.com>
Message-ID: <60750044.6kqqL7c64M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2016 07:50:28 Manuel Lauss wrote:
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: stable at vger.kernel.org # v4.3
> > Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
> > ---
> > I think this is now the last holdout of the irq_to_gpio function,
> > and it's been broken for a while. Maybe Ralf can queue it up through
> > the MIPS tree along with the other fix for irq_to_gpio?
> 
> It's not broken though..  this driver on current linus-git works fine!

Ah, so it doesn't actually need the gpio line then?

irq_to_gpio() unconditionally returns -EINVAL since 4.3, so the easiest
fix would be to remove the card-detect function in the driver, right?

	Arnd
