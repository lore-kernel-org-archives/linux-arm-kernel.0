From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 14 Mar 2017 11:44:30 +0100
Subject: [PATCH -next v2] pinctrl: samsung: Fix return value check in
 samsung_pinctrl_get_soc_data()
In-Reply-To: <CACRpkda1tALy3rmk7FebnR3Xg4WOuUc0Gv1xAmxkd+RLhJ_1VQ@mail.gmail.com>
References: <20170125140321.23911-1-weiyj.lk@gmail.com>
 <20170205155849.4362-1-weiyj.lk@gmail.com>
 <CGME20170213145008epcas3p119bdd6f76468a00fb8d796308ad37698@epcas3p1.samsung.com>
 <CACRpkda0BYLNpPFwpNaEMdeyx61KDUQz_6Y=FQj340pViFjVVQ@mail.gmail.com>
 <c4dd122b-0312-fcca-08e2-4d4586949a88@samsung.com>
 <CACRpkda1tALy3rmk7FebnR3Xg4WOuUc0Gv1xAmxkd+RLhJ_1VQ@mail.gmail.com>
Message-ID: <0eb09039-17c4-5c00-0501-812d4de1ab4a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I have posted proper fix some times ago[1], no need to revert.

[1]: https://www.spinics.net/lists/linux-samsung-soc/msg58395.html

Regards
Andrzej


On 14.03.2017 11:29, Linus Walleij wrote:
> On Tue, Feb 21, 2017 at 2:49 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>> Sadly this patch breaks support for IMEM pinctrl block on Exynos5433/TM2
>> and it took us some time to find the source of the problem.
>>
>> devm_ioremap_resource() is not functionally a full equivalent of
>> devm_ioremap(). The problem here is that registers for IMEM and ALIVE
>> pin controllers are shared and both devices have <0x11090000 0x1000>
>> range in their reg property. devm_ioremap_resource() maps given
>> resource exclusively for the device, while devm_ioremap() allows
>> non-exclusive mappings.
>>
>> This patch has to be reverted asap.
> Patch reverted for fixes, copying the above text as commit message.
>
> Yours,
> Linus Walleij
>
>
>
