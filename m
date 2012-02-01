From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 1 Feb 2012 09:37:36 -0800
Subject: [PATCH] pinctrl: delete raw device pointers in pinmux maps
In-Reply-To: <1328117053-27807-1-git-send-email-linus.walleij@stericsson.com>
References: <1328117053-27807-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178E12470D@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Wednesday, February 01, 2012 10:24 AM:
> After discussion with Mark Brown in an unrelated thread about
> ADC lookups, it came to my knowledge that the ability to pass
> a struct device * in the regulator consumers is just a
> historical artifact, and not really recommended. Since there
> are no in-kernel users of these pointers, we just kill them
> right now, before someone starts to use them.
> 
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I didn't review the code, but just wanted to note that
Documentation/pinctrl.txt needs some updates too, e.g. "Pinmux
board/machine configuration" says:

> As you can see we may have several pin controllers on the system and thus
> we need to specify which one of them that contain the functions we wish
> to map. The map can also use struct device * directly, so there is no
> inherent need to use strings to specify .dev_name or .ctrl_dev_name, these
> are for the situation where you do not have a handle to the struct device *,
> for example if they are not yet instantiated or cumbersome to obtain.

I'm fine with that being a separate patch if you want, or squashing
together two separate patches.

-- 
nvpublic
