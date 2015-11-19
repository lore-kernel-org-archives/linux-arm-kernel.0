From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 19 Nov 2015 18:16:18 +0900
Subject: [PATCH 1/2] clk: samsung: Don't build ARMv8 clock drivers on ARMv7
In-Reply-To: <564D5552.4070806@samsung.com>
References: <1447637775-9887-1-git-send-email-k.kozlowski@samsung.com>
 <1447637775-9887-2-git-send-email-k.kozlowski@samsung.com>
 <CA+Ln22HAGwfPDqXBQatBraLd=DyGYF2WyV4wJ9RvGOc58puymQ@mail.gmail.com>
 <564D5552.4070806@samsung.com>
Message-ID: <CA+Ln22GTPFk6KpWZPDzLRBqO8B+iwwesQEzBwYikXnf0gr3Csg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-19 13:51 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> On 19.11.2015 13:18, Tomasz Figa wrote:
>> However, I don't think we can disable compilation of particular 64-bit
>> SoCs, so maybe there isn't much sense in splitting their clock drivers
>> into separate symbols?
>
> To me it does not really matter. Indeed as you said one cannot disable
> building of one particular Exynos SoCs.
>
> However we could still want not build some parts of such SoCs (like
> clock, pinctrl etc). I don't see much benefit for such case except when
> someone would like to drastically reduce the size of kernel image (for
> whatever reasons he has.).

Can we really build a kernel that support selected Exynos SoC without
its clock driver? Actually I don't think we even allow deselecting
clock drivers currently, because they are not visible in menuconfig.
Unless there is a clear goal to separate ARCH level Kconfig symbol for
particular ARM64-based Exynos SoCs, I don't think it makes any sense
to keep the clock-related symbols separate.

>
> On the other hand having separate symbols causes duplication and
> obfuscates a little the Kconfig/Makefile. I like keeping things simple
> so one symbol for all ARM64 Exynos clocks sounds good.
>
> Sylwester preferred current approach. You and Pankaj seem to prefer one
> symbol-way.

Hmm, I read Sylwester's post as a reply to your original message and
not Pankaj's. Sylwester, could you clarify?

Best regards,
Tomasz
