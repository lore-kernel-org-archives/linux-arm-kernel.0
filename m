From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 19 Nov 2015 18:41:16 +0900
Subject: [PATCH 1/2] clk: samsung: Don't build ARMv8 clock drivers on ARMv7
In-Reply-To: <CA+Ln22GTPFk6KpWZPDzLRBqO8B+iwwesQEzBwYikXnf0gr3Csg@mail.gmail.com>
References: <1447637775-9887-1-git-send-email-k.kozlowski@samsung.com>
 <1447637775-9887-2-git-send-email-k.kozlowski@samsung.com>
 <CA+Ln22HAGwfPDqXBQatBraLd=DyGYF2WyV4wJ9RvGOc58puymQ@mail.gmail.com>
 <564D5552.4070806@samsung.com>
 <CA+Ln22GTPFk6KpWZPDzLRBqO8B+iwwesQEzBwYikXnf0gr3Csg@mail.gmail.com>
Message-ID: <564D993C.4090104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 19.11.2015 o 18:16, Tomasz Figa pisze:
> 2015-11-19 13:51 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>> On 19.11.2015 13:18, Tomasz Figa wrote:
>>> However, I don't think we can disable compilation of particular 64-bit
>>> SoCs, so maybe there isn't much sense in splitting their clock drivers
>>> into separate symbols?
>>
>> To me it does not really matter. Indeed as you said one cannot disable
>> building of one particular Exynos SoCs.
>>
>> However we could still want not build some parts of such SoCs (like
>> clock, pinctrl etc). I don't see much benefit for such case except when
>> someone would like to drastically reduce the size of kernel image (for
>> whatever reasons he has.).
> 
> Can we really build a kernel that support selected Exynos SoC without
> its clock driver? Actually I don't think we even allow deselecting
> clock drivers currently, because they are not visible in menuconfig.
> Unless there is a clear goal to separate ARCH level Kconfig symbol for
> particular ARM64-based Exynos SoCs, I don't think it makes any sense
> to keep the clock-related symbols separate.

That is reasonable and very convincing. I'll wait for Sylwester reply
before re-spinning.

BR,
Krzysztof
