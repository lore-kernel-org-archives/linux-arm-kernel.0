From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Sep 2014 10:29:39 +0200
Subject: [PATCH v2 1/3] clk: samsung: exynos3250: Register DMC clk provider
In-Reply-To: <1409664077-27121-1-git-send-email-k.kozlowski@samsung.com>
References: <1409664077-27121-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <541FDDF3.6020609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.09.2014 15:21, Krzysztof Kozlowski wrote:
> Add clock provider for clocks in DMC domain including EPLL and BPLL. The
> DMC clocks are necessary for Exynos3 devfreq driver.
> 
> The DMC clock domain uses different address space (0x105C0000) than
> standard clock domain (0x10030000 - 0x10050000). The difference is huge
> enough to add new DT node for the clock provider, rather than extending
> existing address space.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Changes since v1:
> =================
> 1. Fix overwritteing main clock provider reg_base with DMC clock domain
>    reg_basr. This leads to OOPS in suspend.

Applied the whole series for next.

Best regards,
Tomasz
