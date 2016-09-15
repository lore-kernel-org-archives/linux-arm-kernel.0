From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 15 Sep 2016 16:13:31 +0200
Subject: [PATCH 4/5] ARM: dts: exynos: add support for ISP power domain to
 exynos4x12 clocks device
In-Reply-To: <6e52af56-8b0e-d8c4-62c2-6efeee0e912d@samsung.com>
References: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
 <1472737551-15272-5-git-send-email-m.szyprowski@samsung.com>
 <20160908002254.GD13062@codeaurora.org>
 <CGME20160912102332eucas1p145e79669788329b44343da62dcbe50ca@eucas1p1.samsung.com>
 <f340cca5-6cd6-6bd1-3b9a-ccd58cbc0091@samsung.com>
 <20160912222852.GH7243@codeaurora.org>
 <6e52af56-8b0e-d8c4-62c2-6efeee0e912d@samsung.com>
Message-ID: <CAPDyKFpibwe2fgviT8z3atd4RJUBx1PMNuG3txbjAa5qY8o_dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>> I see some serious design problems with multiple entries in power domains
>>> property. First how to show that some part of the device IS NOT in
>>> any domain?
>>
>> Is that even possible? Every device should be in some power
>> domain, even if it's just an "always on" power domain that we
>> don't really control from software.
>
>
> Right now none dts of which I'm aware of doesn't define the power domain for
> the parts of the SoC, which are always on and doesn't need any additional
> management.

Actually there's is one reason for doing this, as it would allow
devices to be monitored for device PM QoS constraints by the genpd
governor.

Although, I doubt's someone actually does it because of this benefit,
at least yet.

[...]

Kind regards
Uffe
