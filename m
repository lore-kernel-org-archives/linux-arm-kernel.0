From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 14:47:23 +0100
Subject: [PATCH v2 1/4] pinctrl: samsung: Fix the width of PINCFG_TYPE_DRV
 bitfields for Exynos5433
In-Reply-To: <58AF7CCB.5070303@samsung.com>
References: <CGME20161230041426epcas1p1f827d3cee8b607d81e9921b412ddf301@epcas1p1.samsung.com>
 <20161230041421.24448-1-andi.shyti@samsung.com>
 <20161230041421.24448-2-andi.shyti@samsung.com>
 <CACRpkdbR3x14h38Gg7qpeWnswwD9qsS0zDUrrXCEJH-AdEB+cQ@mail.gmail.com>
 <58AF7CCB.5070303@samsung.com>
Message-ID: <CACRpkda0-k7Vo9Y6yNtLNXu-gGnJW9y83t6W9p032KWjHYdMiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2017 at 1:22 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> On 2016? 12? 30? 22:28, Linus Walleij wrote:
>> On Fri, Dec 30, 2016 at 5:14 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
>>
>>> From: Chanwoo Choi <cw00.choi@samsung.com>
>>>
>>> This patch fixes the wrong width of PINCFG_TYPE_DRV bitfields for Exynos5433
>>> because PINCFG_TYPE_DRV of Exynos5433 has 4bit fields in the *_DRV
>>> registers. Usually, other Exynos have 2bit field for PINCFG_TYPE_DRV.
>>>
>>> Fixes: 3c5ecc9ed353 ("pinctrl: exynos: Add support for Exynos5433")
>>> Cc: stable at vger.kernel.org
>>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Kukjin Kim <kgene@kernel.org>
>>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> Nominally I think you should sign this off too Andi, as you are in the delivery
>> path.
>>
>> Patch applied for fixes.
>
> This patch was already merged on your git and then merge it on tovalds's git[1].
> But, when I checked the latest drivers/pinctrl/samsung/pinctrl-exynos.c,
> it doesn't contain the all codes of patch[1].
> Maybe, I think that there was some merge conflict[2].

Probably. Send a patch fixing it up so I can apply it.

There are now something like 5 different people submitting Samsung pinctrl
patches without coordination so this will start to happen a lot if you keep
up this development pace.

As I just wrote in another mail: I want someone to step up and collect
Samsung patches and send them to me using a pull request.

Samsung people also need to start reviewing each other's patches
more I guess, but mainly I need help with integration.

Yours,
Linus Walleij
