From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Jun 2013 14:32:11 +0200
Subject: [PATCH 1/2] ARM: ux500: Silence compiler warnings due to missing
 ux500_read_asicid() __init
In-Reply-To: <2771350.uHLSSD79no@wuerfel>
References: <1370360208-6500-1-git-send-email-lee.jones@linaro.org>
 <2771350.uHLSSD79no@wuerfel>
Message-ID: <CACRpkdbs=K_aa+mS4EHZk3qVZ1GA-gT6sB1zPOMEVWP=h50WqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 4, 2013 at 5:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 04 June 2013 16:36:47 Lee Jones wrote:
>> WARNING: vmlinux.o(.text.unlikely+0x1e8): Section mismatch in reference from\
>>  the function ux500_read_asicid() to the function .init.text:iotable_init()
>> The function ux500_read_asicid() references
>> the function __init iotable_init().
>> This is often because ux500_read_asicid lacks a __init
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> This is also part of my other patch to ux500_read_asicid that
> Linus just applied, but we could take yours for 3.10 if he thinks
> it's important.

We don't need two patches conflicting about such small
things, so I'll drop this in favor of your patch.

Yours,
Linus Walleij
