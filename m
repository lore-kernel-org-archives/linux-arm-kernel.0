From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 14:58:44 +0800
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect
 Device Tree
In-Reply-To: <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbQv8Q07iRAmG3UQRm7UNDi_Y+s_vvACDKKxR9tg+1iqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The 'name' field in 'struct of_regulator_match' expects to match with
> its corresponding regulator device node in the Device Tree. This patch
> renames each of the regulators in the ab8500 regulator driver so this
> is true.

OK...

> ?static struct of_regulator_match ab8500_regulator_matches[] = {
> - ? ? ? { .name = "LDO-AUX1", ? ?.driver_data = (void *) AB8500_LDO_AUX1, },
> - ? ? ? { .name = "LDO-AUX2", ? ?.driver_data = (void *) AB8500_LDO_AUX2, },
> - ? ? ? { .name = "LDO-AUX3", ? ?.driver_data = (void *) AB8500_LDO_AUX3, },
> - ? ? ? { .name = "LDO-INTCORE", .driver_data = (void *) AB8500_LDO_INTCORE, },
> - ? ? ? { .name = "LDO-TVOUT", ? .driver_data = (void *) AB8500_LDO_TVOUT, },
> - ? ? ? { .name = "LDO-USB", ? ? .driver_data = (void *) AB8500_LDO_USB, },
> - ? ? ? { .name = "LDO-AUDIO", ? .driver_data = (void *) AB8500_LDO_AUDIO, },
> - ? ? ? { .name = "LDO-ANAMIC1", .driver_data = (void *) AB8500_LDO_ANAMIC1, },
> - ? ? ? { .name = "LDO-ANAMIC2", .driver_data = (void *) AB8500_LDO_ANAMIC2, },
> - ? ? ? { .name = "LDO-DMIC", ? ?.driver_data = (void *) AB8500_LDO_DMIC, },
> - ? ? ? { .name = "LDO-ANA", ? ? .driver_data = (void *) AB8500_LDO_ANA, },
> + ? ? ? { .name = "ab8500_ldo_aux1", ? ?.driver_data = (void *) AB8500_LDO_AUX1, },
> + ? ? ? { .name = "ab8500_ldo_aux2", ? ?.driver_data = (void *) AB8500_LDO_AUX2, },
> + ? ? ? { .name = "ab8500_ldo_aux3", ? ?.driver_data = (void *) AB8500_LDO_AUX3, },
> + ? ? ? { .name = "ab8500_ldo_intcore", .driver_data = (void *) AB8500_LDO_INTCORE, },
> + ? ? ? { .name = "ab8500_ldo_tvout", ? .driver_data = (void *) AB8500_LDO_TVOUT, },
> + ? ? ? { .name = "ab8500_ldo_usb", ? ? .driver_data = (void *) AB8500_LDO_USB, },
> + ? ? ? { .name = "ab8500_ldo_audio", ? .driver_data = (void *) AB8500_LDO_AUDIO, },
> + ? ? ? { .name = "ab8500_ldo_anamic1", .driver_data = (void *) AB8500_LDO_ANAMIC1, },
> + ? ? ? { .name = "ab8500_ldo_amamic2", .driver_data = (void *) AB8500_LDO_ANAMIC2, },
> + ? ? ? { .name = "ab8500_ldo_dmic", ? ?.driver_data = (void *) AB8500_LDO_DMIC, },
> + ? ? ? { .name = "ab8500_ldo_ana", ? ? .driver_data = (void *) AB8500_LDO_ANA, },
> ?};

So why is the device tree going to use these lowercase names etc?
I guess there is a rationale...

Anyway: the name is used in more parts of the file, so please change
it everywhere if you change it.

Yours,
Linus Walleij
