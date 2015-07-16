From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jul 2015 21:57:35 +0200
Subject: [PATCH 1/2] ARM: ux500: define serial port aliases
In-Reply-To: <2694937.qjRpGCMvqj@wuerfel>
References: <1436520735-23692-1-git-send-email-linus.walleij@linaro.org>
 <2120032.PN20RpmoKe@wuerfel>
 <CACRpkdaL6DHChx7mSWiGk65LZNxkMGtw=aef2zyHaE7dDhXz8A@mail.gmail.com>
 <2694937.qjRpGCMvqj@wuerfel>
Message-ID: <CACRpkdb3k+s65tOR13iKNLqJ+CWvxSH6d3Z2Ra4OJ9rw+t2Q3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 4:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 16 July 2015 16:03:18 Linus Walleij wrote:

>> The aliases are set also to disabled ports to ensure enumeration
>> for the cases where a board file enabled a previously disabled
>> UART.
>>
>
> Well, both really. The status property tells the kernel to not
> ever touch a device, while the alias is what traditionally gets
> used to assign an OS visible device name to a device in the tree.
> This is more true for MacOS and AIX than Linux, which sometimes
> does its own naming, but we really should not have an alias pointing
> at a disabled device node.

OK ... I will make a patch that remove the aliases for the disabled
nodes.

But this makes me think of whether the DT compiler should allow
it or at least warn about it?

Yours,
Linus Walleij
