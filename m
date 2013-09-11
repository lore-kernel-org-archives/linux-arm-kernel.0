From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Sep 2013 10:06:43 +0200
Subject: [PATCH 01/38] ARM: ux500: Remove PrimeCell IDs from Nomadik I2C
 DT nodes
In-Reply-To: <CAOesGMiBN5SaEY26SxGaw9E4ViR3cC0PcwNMEd4cLJZMfomprQ@mail.gmail.com>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-2-git-send-email-lee.jones@linaro.org>
 <CAOesGMgySNLKo_H0h4MCbAWvyW0h2bWa96drWBpnhAYYQwH9mw@mail.gmail.com>
 <20130910153037.GA11227@lee--X1>
 <CAOesGMiBN5SaEY26SxGaw9E4ViR3cC0PcwNMEd4cLJZMfomprQ@mail.gmail.com>
Message-ID: <CACRpkdY24uU=tXirJqrxLH-45ORFGybJOg-2tDOkpSmFUQUiiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 6:57 PM, Olof Johansson <olof@lixom.net> wrote:

> I have a very weird experience with snowball right now. I noticed this
> yesterday when I decided to look at why multi_v7_defconfig doesn't
> boot on it:
>
> * u8500_defconfig doesn't boot as a DT kernel, since the machine ID is
> still enabled. If I disable the machine ID, it doesn't boot.
> * Same for multi_v7_defconfig, since that is only DT: It doesn't boot.

Weird, yeah there is something wrong on Torvalds' HEAD, with
earlyprint it says:

Uncompressing Linux... done, booting the kernel.
Error: unrecognized/unsupported processor variant (0x412fc091).
This comes from arch/arm/kernel/head-common.S

I'm trying to bisect and find out what is causing this...

Yours,
Linus Walleij
