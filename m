From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Sep 2011 22:32:13 +0200
Subject: [PATCH v2] mach-ep93xx: break out GPIO driver specifics
In-Reply-To: <20110920174012.GE7781@ponder.secretlab.ca>
References: <1316508132-20020-1-git-send-email-linus.walleij@stericsson.com>
	<20110920174012.GE7781@ponder.secretlab.ca>
Message-ID: <CACRpkdazjpKZRfpoYgZ=kC+auEj9q-KMHa6qsWsD+5Hpji+96w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 7:40 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, Sep 20, 2011 at 10:42:12AM +0200, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> The <mach/gpio.h> file is included from upper directories
>> and deal with generic GPIO and gpiolib stuff. Break out the
>> platform and driver specific defines and functions into its own
>> header file.
>>
>> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v1->v2:
>> - Move the irq_to_gpio() into the driver since it was the only
>> ? thing actually using it, as a result the ep93xx gpio.h
>> ? is trivial and becomes empty.
>> - Putting this into the patch tracker as 7042/2 soon-ish.
>> ---
>> ?arch/arm/mach-ep93xx/core.c ? ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-ep93xx/edb93xx.c ? ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h | ?100 +++++++++++++++++++++
>> ?arch/arm/mach-ep93xx/include/mach/gpio.h ? ? ? ?| ?105 -----------------------
>
> Please use the --find-renames flag for patches like this, but otherwise:
>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thanks, I'll fix that.

> Which tree will this go through? ?I don't think it should go via the
> gpio tree since it is mostly within arch/arm.

It'd dependent on Russells cleanups so it'll go through Russells
tree and his gpio cleanup branch there.

Yours,
Linus Walleij
