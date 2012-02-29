From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Feb 2012 18:00:15 +0100
Subject: [PATCH 6/6] ARM: ux500: select I2C for U8500
In-Reply-To: <201202291634.41686.arnd@arndb.de>
References: <1330199334-5133-1-git-send-email-mathieu.poirier@linaro.org>
 <1330199334-5133-6-git-send-email-mathieu.poirier@linaro.org>
 <CACRpkdbGAhwdxE6tYdib0Aiw=9qScmV507npzDU1hkH1xXgxRQ@mail.gmail.com>
 <201202291634.41686.arnd@arndb.de>
Message-ID: <CACRpkdaYmScZKq9rT1z1MEQ4WwJC8Ow7vyS8zBB4r5Q7o6YJTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 5:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 29 February 2012, Linus Walleij wrote:
>> On Sat, Feb 25, 2012 at 8:48 PM, ?<mathieu.poirier@linaro.org> wrote:
>>
>> > From: Arnd Bergmann <arnd@arndb.de>
>> >
>> > The U8500 platform selects the TPS6105X, so also select the I2C
>> > layer that this driver depends on.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> > ---
>> > ?arch/arm/mach-ux500/Kconfig | ? ?1 +
>> > ?1 files changed, 1 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
>> > index c7d1fb5..f0f6199 100644
>> > --- a/arch/arm/mach-ux500/Kconfig
>> > +++ b/arch/arm/mach-ux500/Kconfig
>> > @@ -29,6 +29,7 @@ config MACH_U8500
>> > ? ? ? ?select UX500_SOC_DB8500
>> > ? ? ? ?select TPS6105X
>> > ? ? ? ?select SOC_BUS
>> > + ? ? ? select I2C
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> But should it not also select I2C_NOMADIK, which is surely
>> required too.
>
> That's a different question: I2C is needed to build the kernel
> successfully, while I2C_NOMADIK is (probably) needed to actually
> run on a given hardware.
>
> We normally don't prevent people from selecting silly combinations
> of config options, but we do try to make sure that any random
> configuration actually builds.
>
> Maybe the answer is instead to remove the 'select TPS6105X'
> and make sure the platform actually builds without I2C

Oh yeah wait that's the proper solution. Instead I get to update
the defconfig to include necessary drivers.

I'll post a patch for this instead.

Thanks,
Linus Walleij
