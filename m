From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Oct 2012 01:07:59 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <50682402.8020402@antcom.de>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <CAOY=C6GG6jqqEAAGJjmDG-BFT2eq=9+ck+F_EOcthRgDCDv8=Q@mail.gmail.com>
 <50682402.8020402@antcom.de>
Message-ID: <CACRpkdYGePft_XvhhoNyRfBm484FD46WGagivQzjh5-OE3VJUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 12:50 PM, Roland Stigge <stigge@antcom.de> wrote:

> Besides what I discussed with JC and Linus, I find the unsigned int
> (i.e. u32 or u64, depending on the arch) quite appealing. It is a nice
> compromise between my general bit mapped data model (variable size *u8
> array) and the bool *values list. Even maps easily onto a single sysfs
> entry for values, by abstracting a gpio list to an actual data word.
>
> What do others think? JC? Linus? I'm considering this (unsigned int
> data) a valid option.

I think we mostly use an unsigned long for such stuff as IRQ flags
and ioctl() parameters in the kernel.

In this case it has the upside that it will be 32bit on 32bit systems
and 64bit on 64bit systems if I'm not mistaken.

Yours,
Linus Walleij
