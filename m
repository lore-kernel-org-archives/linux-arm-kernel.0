From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 22 Jul 2010 23:20:00 +0200
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <201007211029.29529.david.jander@protonic.nl>
References: <201007211029.29529.david.jander@protonic.nl>
Message-ID: <AANLkTik4xSSMalj5jVwA4SaHabRYd7c8bH7iTTIwUKQ0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/21 David Jander <david.jander@protonic.nl>:

> General machine initialization like I/O-multiplexing and I/O-pad setup seems
> to be done twice most of the time: Once in the bootloader (i.e. u-boot), and
> once in the machine support file in the linux kernel. This seems awfully
> redundant and error-prone to me. Why is it like this?

I cannot talk for all platforms but on some systems I've worked with
it's not touched by the boot loader but all done by the kernel.

One reason is to keep the bootloader smallish.

Another reason is the ability to slam a kernel into primary memory
and just boot it, with *something else* than a boot loader, e.g.
JTAG. Which proves to be extremely convenient at times.

Yours,
Linus Walleij
