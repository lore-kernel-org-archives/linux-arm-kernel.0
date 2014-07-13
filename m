From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 13 Jul 2014 06:53:31 -0700
Subject: [PATCH 00/13] ARM: OMAP2+: clock cleanup series for 3.17
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Message-ID: <20140713135331.9850.5226@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tero Kristo (2014-07-02 01:47:34)
> Hi,
> 
> This sets cleans up some of the omap specific clock drivers still residing
> under arch/arm/mach-omap2. This set is done in preparation to migrate
> these drivers eventually under drivers/clk/ti, where we don't have access
> to certain board specific functionality. The basic idea of this set is to
> introduce clk_features struct which contains any SoC specific data / flags
> within it, and this is used runtime instead of the current cpu_is_? checks.

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> 
> There are also a couple of bug fixes introduced in this set:
> - Patch #1 : fix potential overflow in _dpll_test_fint
> - Patch #8 : embeds a fix for checking omap5/dra7 for the bypass modes also
> 
> Set tested on following boards:
> 
> - omap2430-sdp : boot
> - omap3-beagle : boot / suspend
> - omap4-panda-es : boot / suspend
> - omap5-uevm : boot
> - dra7-evm : boot
> 
> Branch also available:
> 
> tree: https://github.com/t-kristo/linux-pm.git
> branch: for-v3.17/omap2-clk-cleanup
> 
> -Tero
> 
