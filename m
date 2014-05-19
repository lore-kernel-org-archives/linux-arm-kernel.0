From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 19 May 2014 12:51:36 +0200
Subject: [PATCH v9 0/3] Exynos 5410 support
In-Reply-To: <1400470640-30611-1-git-send-email-t.dakhran@samsung.com>
References: <1400470640-30611-1-git-send-email-t.dakhran@samsung.com>
Message-ID: <5379E238.1080803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarek,

On 19.05.2014 05:37, Tarek Dakhran wrote:
> The series of patches represent support of Exynos 5410 SoC
> 
> The Exynos 5410 is the first Samsung SoC based on big.LITTLE architecture
> 
> Patches add new platform description, support of clock controller and device
> tree for Exynos 5410.
> 
> Has been build on Samsung Linux Kernel
>   (branch: for-next, commit: ccf5511 ARM: EXYNOS: Add MCPM call-back functions)

This doesn't look like an up-to-date tip of that branch. There was a lot
of changes merged 2 days ago, especially from samsung-clk tree and your
patches won't apply and/or compile (at least patch 2/3). Are you sure
you didn't have a git fetch error?

Moreover I can still see the dts using full-path syntax, instead of
reference-based one and also no soc node, as I pointed in v8. [1]

[1] https://lkml.org/lkml/2014/4/26/59

Another thing is that I still see a custom fixed clock binding being
used for oscclk in the clock driver, while I believe I pointed in some
of the previous versions that generic fixed clock should be used.

Best regards,
Tomasz
