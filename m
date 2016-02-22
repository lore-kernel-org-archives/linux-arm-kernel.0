From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 22 Feb 2016 10:26:56 -0800
Subject: [PATCH v5 2/3] clk: samsung: Don't build ARMv8 clock drivers on
 ARMv7
In-Reply-To: <56C44578.5010009@samsung.com>
References: <1455603632-11158-1-git-send-email-k.kozlowski@samsung.com>
 <1455603632-11158-3-git-send-email-k.kozlowski@samsung.com>
 <56C44578.5010009@samsung.com>
Message-ID: <20160222182656.2278.68402@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2016-02-17 02:03:36)
> On 16/02/16 07:20, Krzysztof Kozlowski wrote:
> > Currently the Exynos5433 (ARMv8 SoC) clock driver depends on ARCH_EXYNOS
> > so it is built also on ARMv7. This does not bring any kind of benefit.
> > There won't be a single kernel image for ARMv7 and ARMv8 SoCs (like
> > multi_v7 for ARMv7).
> > 
> > Instead build clock drivers only for respective SoC's architecture.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 

Thanks for the Ack.

I've rebased patches #1 and #2 against James's b9e65ebc654d and pushed
the clk-samsung branch to the clk tree. I have deleted the
clk-samsung-kconfig branch that was blowing up the kbuild robot.
clk-samsung will not be rebased and can be used as a dependency for
arm-soc. It has been merged into clk-next.

Regards,
Mike
