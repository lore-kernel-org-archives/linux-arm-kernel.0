From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 28 Oct 2015 16:24:20 +0900
Subject: [PATCH v2 1/4] ARM: dts: Add SROMc to Exynos 5410
In-Reply-To: <009001d1114f$3c7a1f60$b56e5e20$@samsung.com>
References: <cover.1445935215.git.p.fedin@samsung.com>
 <91ae80f172192fa4dbc8bf8ee5a9068661592de6.1445935215.git.p.fedin@samsung.com>
 <56302F1F.5090206@samsung.com> <009001d1114f$3c7a1f60$b56e5e20$@samsung.com>
Message-ID: <56307824.1050302@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.10.2015 16:06, Pavel Fedin wrote:
>  Hello!
> 
>>> +		sromc: sromc at 12250000 {
>>> +			compatible = "samsung,exynos-srom";
>>> +			reg = <0x12250000 0x10>;
>>
>> Isn't 0x10 too small (SROM_BC3 won't be mapped)?
> 
>  Muhaha, indeed, thanks for noticing this.
>  By the way, i've just checked exynos4.dtsi and exynos5.dtsi, they specify the same size. Did reviewers overlook this small thing?

Yep, I pointed that 0x100 (from first version of patchset) is too big...
but did not exactly check the length of new value.

> Shouldn't it be fixed then?

Yes. It hasn't been pulled yet by arm-soc... Let's wait Kukjin's opinion
how to deal with exynos[45].dtsi.

Best regards,
Krzysztof
