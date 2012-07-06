From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 06 Jul 2012 08:45:35 +0100
Subject: [PATCH 3/9] ARM: ux500: Remove AB8500 regulator register
 initialisation information
In-Reply-To: <CACRpkdbRtFX8_++rndCpsH7R1uhwPrkTE_GKgNTM6r1PSuwY0A@mail.gmail.com>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-4-git-send-email-lee.jones@linaro.org>
 <CACRpkdbRtFX8_++rndCpsH7R1uhwPrkTE_GKgNTM6r1PSuwY0A@mail.gmail.com>
Message-ID: <4FF6979F.2000904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/12 07:55, Linus Walleij wrote:
> On Thu, Jul 5, 2012 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
>> There is no need to initialise the AB8500's regulator registers, as
>> most of this work is already carried out by framework features, so
>> we can safely remove all traces from platform code.
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> NACK, sorry.
>
> These registers are used to set up sleep states for the regulators,
> e.g that some regulators will turn off when the system go to sleep.
>
> If you delete this code it's no longer possible to make the system
> powerefficient, power consumption increases so it causes a
> regression.
>
> The proper thing to do is to take the AB8500 datasheet, go in and
> read what these registers actually do, and provide the same
> features through the framework, if just poking the registers
> is deemed non-elegant (I see the point in that).
>
> This is the AB8500 datasheet:
> http://www.stericsson.com/developers/CD00291561_UM1031_AB8500_user_manual-rev5_CTDS_public.pdf
>
> So please refactor this, don't just delete, that's destroying a lot
> of useful stuff.

Sounds reasonable. I won't be doing the refactoring, as I'm moving onto 
something else from Monday. Unless of course I find myself with lots of 
spare time *chuckles*.

Mark,

Please take a note of this and also do not apply the regulator driver 
counterpart of the patch-set (it was one of the ones you Reviewed-by in 
the previous batch).

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
