From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Jan 2018 16:22:08 +0100
Subject: [PATCH] ARM: dts: nomadik: add interrupt-parent for clcd
In-Reply-To: <CACRpkdYCu57Y0KZGt9c7iM6nwe7qCxK+PcPC5God-rnOoHFt4Q@mail.gmail.com>
References: <20180115163719.1736753-1-arnd@arndb.de>
 <CACRpkdYCu57Y0KZGt9c7iM6nwe7qCxK+PcPC5God-rnOoHFt4Q@mail.gmail.com>
Message-ID: <CAK8P3a0TJ0dLruRexUQ9N6A0Yrqw2Lk403uBnSjHh0M2L3oj_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 8:29 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jan 15, 2018 at 5:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> The clcd device is lacking an interrupt-parent property, which makes
>> the interrupt unusable and shows up as a warning with the latest
>> dtc version:
>>
>> arch/arm/boot/dts/ste-nomadik-s8815.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd at 10120000
>> arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning (interrupts_property): Missing interrupt-parent for /amba/clcd at 10120000
>>
>> I looked up the old board files and found that this interrupt has
>> the same irqchip as all the other on-chip device, it just needs one
>> extra line.
>>
>> Fixes: 17470b7da11c ("ARM: dts: add the CLCD LCD display to the NHK15")
>> Cc: stable at vger.kernel.org
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Sorry for not getting to fixing this myself quickly enough.

Applied to next/dt, thanks!

      Arnd
