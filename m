From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 12:41:51 +0100
Subject: [PATCH 11/19] clk: samsung: exynos5433: Add clocks for
 CMU_BUS{0|1|2} domains
In-Reply-To: <1417073716-22997-12-git-send-email-cw00.choi@samsung.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <1417073716-22997-12-git-send-email-cw00.choi@samsung.com>
Message-ID: <6217579.xNXtO7YiDs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 16:35:08 Chanwoo Choi wrote:
> +  - "samsung,exynos5433-cmu-bus0", "samsung,exynos5433-cmu-bus1"
> +    and "samsung,exynos5433-cmu-bus2" - clock controller compatible for CMU_BUS
> +    which generates global data buses clock and global peripheral buses clock.
>  
>  - reg: physical base address of the controller and length of memory mapped
>    region.
> 

This looks like you are duplicating the bindings and the code, but
it's really the same hardware multiple times with minor variations
that you should be able to describe properly here. Why not make
three nodes with the same compatible string and have them handled
by the same code?

	Arnd
