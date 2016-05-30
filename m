From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 30 May 2016 15:27:16 +0200
Subject: [PATCH v3 2/4] dt-bindings: reset: Add bindings for the Meson SoC
 Reset Controller
In-Reply-To: <1464614838-28107-1-git-send-email-narmstrong@baylibre.com>
References: <1464614838-28107-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1464614838-28107-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for the Meson SoC Reset Controller documentation and the
associated include file.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/reset/amlogic,meson-reset.txt         |  18 ++
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   | 210 +++++++++++++++++++++
 include/dt-bindings/reset/amlogic,meson8b-reset.h  | 175 +++++++++++++++++
 3 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
 create mode 100644 include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson8b-reset.h

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
new file mode 100644
index 0000000..e746b63
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
@@ -0,0 +1,18 @@
+Amlogic Meson SoC Reset Controller
+=======================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: Should be "amlogic,meson8b-reset" or "amlogic,meson-gxbb-reset"
+- reg: should contain the register address base
+- #reset-cells: 1, see below
+
+example:
+
+reset: reset-controller {
+	compatible = "amlogic,meson-gxbb-reset";
+	reg = <0x0 0x04404 0x0 0x20>;
+	#reset-cells = <1>;
+};
diff --git a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
new file mode 100644
index 0000000..524d607
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
@@ -0,0 +1,210 @@
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * The full GNU General Public License is included in this distribution
+ * in the file called COPYING.
+ *
+ * BSD LICENSE
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in
+ *     the documentation and/or other materials provided with the
+ *     distribution.
+ *   * Neither the name of Intel Corporation nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef _DT_BINDINGS_AMLOGIC_MESON_GXBB_RESET_H
+#define _DT_BINDINGS_AMLOGIC_MESON_GXBB_RESET_H
+
+/*	RESET0					*/
+#define RESET_HIU			0
+/*					1	*/
+#define RESET_DOS_RESET			2
+#define RESET_DDR_TOP			3
+#define RESET_DCU_RESET			4
+#define RESET_VIU			5
+#define RESET_AIU			6
+#define RESET_VID_PLL_DIV		7
+/*					8	*/
+#define RESET_PMUX			9
+#define RESET_VENC			10
+#define RESET_ASSIST			11
+#define RESET_AFIFO2			12
+#define RESET_VCBUS			13
+/*					14	*/
+/*					15	*/
+#define RESET_GIC			16
+#define RESET_CAPB3_DECODE		17
+#define RESET_NAND_CAPB3		18
+#define RESET_HDMITX_CAPB3		19
+#define RESET_MALI_CAPB3		20
+#define RESET_DOS_CAPB3			21
+#define RESET_SYS_CPU_CAPB3		22
+#define RESET_CBUS_CAPB3		23
+#define RESET_AHB_CNTL			24
+#define RESET_AHB_DATA			25
+#define RESET_VCBUS_CLK81		26
+#define RESET_MMC			27
+#define RESET_MIPI_0			28
+#define RESET_MIPI_1			29
+#define RESET_MIPI_2			30
+#define RESET_MIPI_3			31
+/*	RESET1					*/
+#define RESET_CPPM			32
+#define RESET_DEMUX			33
+#define RESET_USB_OTG			34
+#define RESET_DDR			35
+#define RESET_AO_RESET			36
+#define RESET_BT656			37
+#define RESET_AHB_SRAM			38
+/*					39	*/
+#define RESET_PARSER			40
+#define RESET_BLKMV			41
+#define RESET_ISA			42
+#define RESET_ETHERNET			43
+#define RESET_SD_EMMC_A			44
+#define RESET_SD_EMMC_B			45
+#define RESET_SD_EMMC_C			46
+#define RESET_ROM_BOOT			47
+#define RESET_SYS_CPU_0			48
+#define RESET_SYS_CPU_1			49
+#define RESET_SYS_CPU_2			50
+#define RESET_SYS_CPU_3			51
+#define RESET_SYS_CPU_CORE_0		52
+#define RESET_SYS_CPU_CORE_1		53
+#define RESET_SYS_CPU_CORE_2		54
+#define RESET_SYS_CPU_CORE_3		55
+#define RESET_SYS_PLL_DIV		56
+#define RESET_SYS_CPU_AXI		57
+#define RESET_SYS_CPU_L2		58
+#define RESET_SYS_CPU_P			59
+#define RESET_SYS_CPU_MBIST		60
+/*					61	*/
+/*					62	*/
+/*					63	*/
+/*	RESET2					*/
+#define RESET_VD_RMEM			64
+#define RESET_AUDIN			65
+#define RESET_HDMI_TX			66
+/*					67	*/
+/*					68	*/
+/*					69	*/
+#define RESET_GE2D			70
+#define RESET_PARSER_REG		71
+#define RESET_PARSER_FETCH		72
+#define RESET_PARSER_CTL		73
+#define RESET_PARSER_TOP		74
+/*					75	*/
+/*					76	*/
+#define RESET_AO_CPU_RESET		77
+#define RESET_MALI			78
+#define RESET_HDMI_SYSTEM_RESET		79
+/*					80-95	*/
+/*	RESET3					*/
+#define RESET_RING_OSCILLATOR		96
+#define RESET_SYS_CPU			97
+#define RESET_EFUSE			98
+#define RESET_SYS_CPU_BVCI		99
+#define RESET_AIFIFO			100
+#define RESET_TVFE			101
+#define RESET_AHB_BRIDGE_CNTL		102
+/*					103	*/
+#define RESET_AUDIO_DAC			104
+#define RESET_DEMUX_TOP			105
+#define RESET_DEMUX_DES			106
+#define RESET_DEMUX_S2P_0		107
+#define RESET_DEMUX_S2P_1		108
+#define RESET_DEMUX_RESET_0		109
+#define RESET_DEMUX_RESET_1		110
+#define RESET_DEMUX_RESET_2		111
+/*					112-127	*/
+/*	RESET4					*/
+/*					128	*/
+/*					129	*/
+/*					130	*/
+/*					131	*/
+#define RESET_DVIN_RESET		132
+#define RESET_RDMA			133
+#define RESET_VENCI			134
+#define RESET_VENCP			135
+/*					136	*/
+#define RESET_VDAC			137
+#define RESET_RTC			138
+/*					139	*/
+#define RESET_VDI6			140
+#define RESET_VENCL			141
+#define RESET_I2C_MASTER_2		142
+#define RESET_I2C_MASTER_1		143
+/*					144-159	*/
+/*	RESET5					*/
+/*					160-191	*/
+/*	RESET6					*/
+#define RESET_PERIPHS_GENERAL		192
+#define RESET_PERIPHS_SPICC		193
+#define RESET_PERIPHS_SMART_CARD	194
+#define RESET_PERIPHS_SAR_ADC		195
+#define RESET_PERIPHS_I2C_MASTER_0	196
+#define RESET_SANA			197
+/*					198	*/
+#define RESET_PERIPHS_STREAM_INTERFACE	199
+#define RESET_PERIPHS_SDIO		200
+#define RESET_PERIPHS_UART_0		201
+#define RESET_PERIPHS_UART_1_2		202
+#define RESET_PERIPHS_ASYNC_0		203
+#define RESET_PERIPHS_ASYNC_1		204
+#define RESET_PERIPHS_SPI_0		205
+#define RESET_PERIPHS_SDHC		206
+#define RESET_UART_SLIP			207
+/*					208-223	*/
+/*	RESET7					*/
+#define RESET_USB_DDR_0			224
+#define RESET_USB_DDR_1			225
+#define RESET_USB_DDR_2			226
+#define RESET_USB_DDR_3			227
+/*					228	*/
+#define RESET_DEVICE_MMC_ARB		229
+/*					230	*/
+#define RESET_VID_LOCK			231
+#define RESET_A9_DMC_PIPEL		232
+/*					233-255	*/
+
+#endif
diff --git a/include/dt-bindings/reset/amlogic,meson8b-reset.h b/include/dt-bindings/reset/amlogic,meson8b-reset.h
new file mode 100644
index 0000000..614aff2
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,meson8b-reset.h
@@ -0,0 +1,175 @@
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * The full GNU General Public License is included in this distribution
+ * in the file called COPYING.
+ *
+ * BSD LICENSE
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in
+ *     the documentation and/or other materials provided with the
+ *     distribution.
+ *   * Neither the name of Intel Corporation nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef _DT_BINDINGS_AMLOGIC_MESON8B_RESET_H
+#define _DT_BINDINGS_AMLOGIC_MESON8B_RESET_H
+
+/*	RESET0					*/
+#define RESET_HIU			0
+#define RESET_VLD			1
+#define RESET_IQIDCT			2
+#define RESET_MC			3
+/*					8	*/
+#define RESET_VIU			5
+#define RESET_AIU			6
+#define RESET_MCPU			7
+#define RESET_CCPU			8
+#define RESET_PMUX			9
+#define RESET_VENC			10
+#define RESET_ASSIST			11
+#define RESET_AFIFO2			12
+#define RESET_MDEC			13
+#define RESET_VLD_PART			14
+#define RESET_VIFIFO			15
+/*					16-31	*/
+/*	RESET1					*/
+/*					32	*/
+#define RESET_DEMUX			33
+#define RESET_USB_OTG			34
+#define RESET_DDR			35
+#define RESET_VDAC_1			36
+#define RESET_BT656			37
+#define RESET_AHB_SRAM			38
+#define RESET_AHB_BRIDGE		39
+#define RESET_PARSER			40
+#define RESET_BLKMV			41
+#define RESET_ISA			42
+#define RESET_ETHERNET			43
+#define RESET_ABUF			44
+#define RESET_AHB_DATA			45
+#define RESET_AHB_CNTL			46
+#define RESET_ROM_BOOT			47
+/*					48-63	*/
+/*	RESET2					*/
+#define RESET_VD_RMEM			64
+#define RESET_AUDIN			65
+#define RESET_DBLK			66
+#define RESET_PIC_DC			66
+#define RESET_PSC			66
+#define RESET_NAND			66
+#define RESET_GE2D			70
+#define RESET_PARSER_REG		71
+#define RESET_PARSER_FETCH		72
+#define RESET_PARSER_CTL		73
+#define RESET_PARSER_TOP		74
+#define RESET_HDMI_APB			75
+#define RESET_AUDIO_APB			76
+#define RESET_MEDIA_CPU			77
+#define RESET_MALI			78
+#define RESET_HDMI_SYSTEM_RESET		79
+/*					80-95	*/
+/*	RESET3					*/
+#define RESET_RING_OSCILLATOR		96
+#define RESET_SYS_CPU_0			97
+#define RESET_EFUSE			98
+#define RESET_SYS_CPU_BVCI		99
+#define RESET_AIFIFO			100
+#define RESET_AUDIO_PLL_MODULATOR	101
+#define RESET_AHB_BRIDGE_CNTL		102
+#define RESET_SYS_CPU_1			103
+#define RESET_AUDIO_DAC			104
+#define RESET_DEMUX_TOP			105
+#define RESET_DEMUX_DES			106
+#define RESET_DEMUX_S2P_0		107
+#define RESET_DEMUX_S2P_1		108
+#define RESET_DEMUX_RESET_0		109
+#define RESET_DEMUX_RESET_1		110
+#define RESET_DEMUX_RESET_2		111
+/*					112-127	*/
+/*	RESET4					*/
+#define RESET_PL310			128
+#define RESET_A5_APB			129
+#define RESET_A5_AXI			130
+#define RESET_A5			131
+#define RESET_DVIN			132
+#define RESET_RDMA			133
+#define RESET_VENCI			134
+#define RESET_VENCP			135
+#define RESET_VENCT			136
+#define RESET_VDAC_4			137
+#define RESET_RTC			138
+#define RESET_A5_DEBUG			139
+#define RESET_VDI6			140
+#define RESET_VENCL			141
+/*					142-159	*/
+/*	RESET5					*/
+#define RESET_DDR_PLL			160
+#define RESET_MISC_PLL			161
+#define RESET_SYS_PLL			162
+#define RESET_HPLL_PLL			163
+#define RESET_AUDIO_PLL			164
+#define RESET_VID2_PLL			165
+/*					166-191	*/
+/*	RESET6					*/
+#define RESET_PERIPHS_GENERAL		192
+#define RESET_PERIPHS_IR_REMOTE		193
+#define RESET_PERIPHS_SMART_CARD	194
+#define RESET_PERIPHS_SAR_ADC		195
+#define RESET_PERIPHS_I2C_MASTER_0	196
+#define RESET_PERIPHS_I2C_MASTER_1	197
+#define RESET_PERIPHS_I2C_SLAVE		198
+#define RESET_PERIPHS_STREAM_INTERFACE	199
+#define RESET_PERIPHS_SDIO		200
+#define RESET_PERIPHS_UART_0		201
+#define RESET_PERIPHS_UART_1		202
+#define RESET_PERIPHS_ASYNC_0		203
+#define RESET_PERIPHS_ASYNC_1		204
+#define RESET_PERIPHS_SPI_0		205
+#define RESET_PERIPHS_SPI_1		206
+#define RESET_PERIPHS_LED_PWM		207
+/*					208-223	*/
+/*	RESET7					*/
+/*					224-255	*/
+
+#endif
-- 
2.7.0
