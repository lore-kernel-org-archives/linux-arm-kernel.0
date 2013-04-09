From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Apr 2013 09:40:15 +0200
Subject: [PATCH 2/6] pinctrl: samsung: Include pinctrl-exynos driver data
 conditionally
In-Reply-To: <1733680.zsxXgkCci5@flatron>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
 <1363642315-10331-3-git-send-email-tomasz.figa@gmail.com>
 <1733680.zsxXgkCci5@flatron>
Message-ID: <CACRpkdb63vNQ_63NLPrK0mx=W4ecBeksY=GNMpJRLsAyzfb65A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 10:38 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Monday 18 of March 2013 22:31:51 Tomasz Figa wrote:
>> Since pinctrl-samsung is a common part of the pin control support for
>> several Samsung SoCs, it can be compiled without Exynos support enabled.
>>
>> This patch surrounds Exynos-specific driver data with ifdefs to include
>> them only when support for Exynos is enabled.
>>
>> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>> ---
>>  drivers/pinctrl/pinctrl-samsung.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pinctrl/pinctrl-samsung.c
>> b/drivers/pinctrl/pinctrl-samsung.c index b1d4ac8..f1fb562 100644
>> --- a/drivers/pinctrl/pinctrl-samsung.c
>> +++ b/drivers/pinctrl/pinctrl-samsung.c
>> @@ -968,10 +968,12 @@ static int samsung_pinctrl_probe(struct
>> platform_device *pdev) }
>>
>>  static const struct of_device_id samsung_pinctrl_dt_match[] = {
>> +#ifdef CONFIG_PINCTRL_EXYNOS4
>
> Oops... This should be CONFIG_PINCTRL_EXYNOS. It used to be EXYNOS4 in
> Kgene's tree (on which I usually base my patches) for some time, but it no
> longer is, but I forgot to change this during rebae.
>
> Linus, if remaining patches turned out to be OK, would you fix this when
> applying?

Fixed and applied.

Thanks!
Linus Walleij
