From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jan 2017 16:42:43 +0100
Subject: [PATCH v3 REBASED 11/13] pinctrl: samsung: Move retention control
 from mach-exynos to the pinctrl driver
In-Reply-To: <CACRpkdaCwfm6aU4kNBgmhmRzEiASkBWY-pX=3FqERtyG+55sqQ@mail.gmail.com>
References: <CACRpkdY_SpqfyTTqSP5+a1k1LDf_5w77UXo=EognmOzWBz2c-Q@mail.gmail.com>
 <CGME20170126093002eucas1p1d2c86542c56bd54d78852693f9ddb0b2@eucas1p1.samsung.com>
 <1485422967-30643-1-git-send-email-m.szyprowski@samsung.com>
 <1485422967-30643-8-git-send-email-m.szyprowski@samsung.com>
 <CACRpkdaCwfm6aU4kNBgmhmRzEiASkBWY-pX=3FqERtyG+55sqQ@mail.gmail.com>
Message-ID: <CACRpkdb+nfV17zLaer8ULnV_z5-w3qQQysuBNrv2cKbMGcTdsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 4:38 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jan 26, 2017 at 10:29 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>> This patch moves pad retention control from PMU driver to Exynos pin
>> controller driver. This helps to avoid possible ordering and logical
>> dependencies between machine, PMU and pin control code. Till now it
>> worked fine only because sys_ops for PMU and pin controller were called
>> in registration order.
>> This is also a preparation for adding new features to Exynos pin
>> controller driver, like runtime power management and suspending
>> individual pin controllers, which might be a part of some power domain.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
>
> Patch applied with Arnd's ACK and THANKS for cleaning up the
> ARM tree.

Or no, hehe, better keep myself in check.

Backed this and the next patch because of my complaints
about the necessarily custom soc header.

I guess I could anyways continue from this point in the
series if I just pull in that branch if we conclude it is the best
thing to do.

Yours,
Linus Walleij
