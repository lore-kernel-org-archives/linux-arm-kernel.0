From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 24 Feb 2015 08:59:22 +0100
Subject: [RESEND PATCH] ARM: EXYNOS: Fix failed second suspend on Exynos4
In-Reply-To: <54EBE43C.1020901@samsung.com>
References: <1424256325-16659-1-git-send-email-k.kozlowski@samsung.com>
 <54EBE43C.1020901@samsung.com>
Message-ID: <1424764762.2877.3.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2015-02-24 at 11:38 +0900, Chanwoo Choi wrote:
> Hi Krzysztof,
> 
> I tested this patch for suspend-to-ram on Exynos4412-based trats2 board.
> When I tested suspend-to-ram repetitively, I faced on hang issue of
> suspend-to-ram for Exynos4 as before.
> 
> Could you send .config file for test?

I am testing on exynos_defconfig with some stuff enabled (nothing
special: regulators, chargers, PM_ADVANCED_DEBUG, extcon etc.). However
sometimes I also see hangs related to MMC. But I believe this issue is
present for some time and is not related to my DELAYED_RESET_ASSERTION
changes.

Maybe you could try to boot with "no_console_suspend loglevel=7" and see
when the suspend fails?

Best regards,
Krzysztof
