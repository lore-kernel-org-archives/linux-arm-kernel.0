From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Tue, 10 Mar 2015 16:32:29 +0100
Subject: ARCH_EXYNOS5433 missing in Kconfig
Message-ID: <CAD3Xx4Jf5ACBKe-KvGRD=myHKrJ+K_P0vBrtrmfgh+1zNM4hug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

your commit 96bd6224f07b ("clk: samsung: exynos5433: Add clocks using
common clock framework") is included in today's linux-next tree (i.e.,
next-20150310).

This patch conditionally compiles clk-exynos5433.c depending on the
Kconfig option ARCH_EXYNOS5433.  However, this option is not defined
in Kconfig, so that the driver cannot be compiled at the current
state:

+obj-$(CONFIG_ARCH_EXYNOS5433)  += clk-exynos5433.o

Is there a patch queued somewhere that adds this Kconfig symbol?  I
detected the issue by running undertaker-checkpatch from the
Undertaker tool suite (undertaker.cs.fau.de).  There is also a tool in
the git tree that can detect such issues (i.e.,
scripts/checkkconfigsymbols.py).

Kind regards,
 Valentin
