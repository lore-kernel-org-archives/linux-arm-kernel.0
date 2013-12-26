From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 26 Dec 2013 15:48:57 +0530
Subject: [PATCH RESEND 0/4] Add support for clocks in S5M8767
In-Reply-To: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1388053141-30085-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5M8767 chip has 3 crystal oscillators which are operated in the same
as the crystal oscillators in S2MPS11. Extend s2mps11-clk driver to
support clocks in S5M8767.

The earlier set of patches no longer apply cleanly on linux-next, hence
rebased them on top of next-20131224.

Tushar Behera (4):
  clk: clk-s2mps11: Refactor for including support for other MFD clocks
  clk: clk-s2mps11: Add support for clocks in S5M8767 MFD
  mfd: sec-core: Add cells for S5M8767-clocks
  ARM: dts: Add S5M8767 clock nodes on Arndale board

 arch/arm/boot/dts/exynos5250-arndale.dts |    7 +++++++
 drivers/clk/Kconfig                      |    6 ++++--
 drivers/clk/clk-s2mps11.c                |   25 +++++++++++++++++++++----
 drivers/mfd/sec-core.c                   |    4 +++-
 4 files changed, 35 insertions(+), 7 deletions(-)

-- 
1.7.9.5
