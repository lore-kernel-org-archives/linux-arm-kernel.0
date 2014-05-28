From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 May 2014 15:32:56 +0200
Subject: [PATCH v3 4/7] of: configure the platform device dma parameters
In-Reply-To: <4960549.viM91iY2g2@wuerfel>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <5840140.8yGnd4Ycx3@wuerfel>
 <CACRpkdZjEVYgq7tKEfmZC0Fu4n=JuUues=pAAtquLahkex=pkA@mail.gmail.com>
 <4960549.viM91iY2g2@wuerfel>
Message-ID: <CACRpkda5x-fJWTN40ze17woMWuWoVbuhbNu5nkm1sFcdJchRfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 3:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 28 May 2014 10:23:09 Linus Walleij wrote:

>>         model = "ARM Integrator/AP";
>>         compatible = "arm,integrator-ap";
>> +       dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
>>
>>         aliases {
>>                 arm,timer-primary = &timer2;
>>
>
> It looks like you accidentally copied the ranges from keystone, even
> though that has a 64-bit root bus and you only have 32-bit.

Nah it was no accident, just good old incompetence ;-)

> I suspect what you want is
>
>         dma-ranges = <0x80000000 0 0x80000000>;
>
> to translate dma_addr_t 0x80000000-0xffffffff to phys_addr_t 0x0-0x7fffffff
> rather than phys_addr_t 0x800000000-0x87fffffff.

Thanks, I'll fix up my patch.

Yours,
Linus Walleij
