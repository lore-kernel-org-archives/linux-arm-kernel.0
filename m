From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 26 Jul 2013 12:32:11 +0800
Subject: [PATCH v6 0/6] support Hisilicon SoC
Message-ID: <1374813135-16238-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v6:
1. Remove hisilicon string from properties in clock driver.
2. Replace array by pointer in clock driver. Since only sctrl parent
   node exists at this time.

v5:
1. Remove HIWORD clk patches since they're merged into clk git tree.
2. Set hisilicon,clk-reset property of clkgate node is optional.
3. Update on commandline args in DTS file. Remove earlyprintk, mem, nfs.
4. Move gpio-keys out of amba node in DTS file.

v4:
1. Add clk gate with HIWORD mask for Rockchip.
2. Update comments and code of HIWORD flags for mux/divider.
3. Append a mux without HIWORD mask in Hisilicon 3620.
4. Fix the pinmux setting in Hi4511.

v3:
1. Use clk_register_mux_table().

v2:
1. Reuse mux & divider driver. So append CLK_MUX_HIWORD_MASK &
CLK_DIVIDER_HIWORD_MASK for Hi3620 SoC.
2. Fix system timer running too fast because wrong divider is choosen.
3. Remove .init_irq in DT machine descriptor.
