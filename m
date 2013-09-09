From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Sep 2013 11:15:21 +0200
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a7791 SoC support
In-Reply-To: <CANqRtoQ0dnG6HwjJSrK8+Qt8wvJhqsJHxgj-LGvnJvS0KT81nw@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034557.12546.97503.sendpatchset@w520>
 <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
 <CANqRtoQzLKk3EKcm=EiZCg73fgDBZ1xjPi_6fH_PsGdkr6w5sA@mail.gmail.com>
 <CACRpkdZGLR3=UZ7f-9r02Gea2hTomp+6+bz0BDQOvk9zRHTxxw@mail.gmail.com>
 <CANqRtoQ0dnG6HwjJSrK8+Qt8wvJhqsJHxgj-LGvnJvS0KT81nw@mail.gmail.com>
Message-ID: <CACRpkdY44c_qzQ6XVjCs86axta-0VBqL8ygH5j+q3z294YXjLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 9, 2013 at 10:05 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> At
> this time though, apart from common clocks, extended DT support and
> multiplatform I'm not so sure what desired cleanup-wise.

It'd be nice to switch shmobile to use AUTO_ZRELADDR, as it is
the other criteria (apart from common clock) standing in the way
for multiplatform. (Maybe this just works if you turn it on?)

For multiplatform you also have to depopulate <mach/*>
completely, either move stuff down into the mach-folder
or to <linux/platform_data/*> if absolutely necessary.
This will be quite some work, especially if the <mach/*>
path is used in a lot of drivers...

Then we have a quite broad consensus to depopulate arch/arm/*
of drivers, so for shmobile:

clock* -> drivers/clk
cpuidle.c -> drivers/cpuidle (or was this just fixed?)
intc* -> drivers/irqchips
sh-gpio.c -> drivers/pinctrl/gpio

The last one I know you will soon finish.

Then deleteing all board file stuff that is not using DT.

After all that it's top-notch I think :-)

Yours,
Linus Walleij
