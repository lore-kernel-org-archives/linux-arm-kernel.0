From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 23 Apr 2012 17:55:20 +0530
Subject: [PATCH 1/9] SPEAr13xx: Add header files
In-Reply-To: <CAOh2x==CVfODg=iOKPrQq2HYMAEFUBpwkrkZwW3f5As7Z2pTdA@mail.gmail.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
 <201204201752.05657.arnd@arndb.de>
 <CAOh2x=ncefojSYBPUVgL1EKcQ+wPFzfCmo+TZ+3BEmwD+=Q=Gg@mail.gmail.com>
 <201204211837.35023.arnd@arndb.de>
 <CAOh2x==CVfODg=iOKPrQq2HYMAEFUBpwkrkZwW3f5As7Z2pTdA@mail.gmail.com>
Message-ID: <CAOh2x==Oq+um-9Bz8j1s8iY2zRq=so79kQmKBc9-J-k78=xMUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/23/12, viresh kumar <viresh.linux@gmail.com> wrote:
> On Sun, Apr 22, 2012 at 12:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> It's still really ugly to have that in a global header file, including
>> the
>> hardcoded register addresses.
>
> I will check if i can move this to clock.c for now, to move things quicker.
> :)

Will squash following with this patch in my pull request, if i don't need
to send V3:

From: Viresh Kumar <viresh.kumar@st.com>
Date: Mon, 23 Apr 2012 17:35:36 +0530
Subject: [PATCH 1/2] fixup! SPEAr13xx: Add header files

Remove 1310 specific register declarations from spear.h

---
 arch/arm/mach-spear13xx/include/mach/spear.h |   99 --------------------------
 1 files changed, 0 insertions(+), 99 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h
b/arch/arm/mach-spear13xx/include/mach/spear.h
index 57fb960..30c57ef 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -53,105 +53,6 @@
 #define VA_SPEAR1310_RAS_GRP1_BASE		UL(0xFA000000)
 #define SPEAR1310_RAS_BASE			UL(0xD8400000)
 #define VA_SPEAR1310_RAS_BASE			IOMEM(UL(0xFA400000))
-
-/* RAS Area Control Register */
-#define SPEAR1310_RAS_CTRL_REG0			(VA_SPEAR1310_RAS_BASE + 0x000)
-	#define SPEAR1310_GPT64_SYNC_ENB		0
-	#define SPEAR1310_GPT64_SYNC_ENB_MASK		1
-	#define SPEAR1310_GPT64_SYNC_ENB_SHIFT		31
-	#define SPEAR1310_SSP1_CS_SEL_CS0		0
-	#define SPEAR1310_SSP1_CS_SEL_CS1		1
-	#define SPEAR1310_SSP1_CS_SEL_MASK		3
-	#define SPEAR1310_SSP1_CS_SEL_SHIFT		30
-	#define SPEAR1310_SSP1_CS_VAL_MASK		1
-	#define SPEAR1310_SSP1_CS_VAL_SHIFT		28
-	#define SPEAR1310_SSP1_CS_CTL_HW		0
-	#define SPEAR1310_SSP1_CS_CTL_SW		1
-	#define SPEAR1310_SSP1_CS_CTL_MASK		1
-	#define SPEAR1310_SSP1_CS_CTL_SHIFT		27
-	#define SPEAR1310_SSP1_CLK_PCLK_VAL		0
-	#define SPEAR1310_SSP1_CLK_RAS_SYNT1_VAL	1
-	#define SPEAR1310_SSP1_CLK_RAS_PLCLK0_VAL	2
-	#define SPEAR1310_SSP1_CLK_MASK			3
-	#define SPEAR1310_SSP1_CLK_SHIFT		26
-	#define SPEAR1310_TDM_CLK_PLL3_VAL		0
-	#define SPEAR1310_TDM_CLK_RAS_SYNT1_VAL		1
-	#define SPEAR1310_TDM_CLK_MASK			1
-	#define SPEAR1310_TDM2_CLK_SHIFT		24
-	#define SPEAR1310_TDM1_CLK_SHIFT		23
-	#define SPEAR1310_I2C_CLK_PCLK_VAL		0
-	#define SPEAR1310_I2C_CLK_RAS_SYNT1_VAL		1
-	#define SPEAR1310_I2C_CLK_MASK			1
-	#define SPEAR1310_I2C7_CLK_SHIFT		22
-	#define SPEAR1310_I2C6_CLK_SHIFT		21
-	#define SPEAR1310_I2C5_CLK_SHIFT		20
-	#define SPEAR1310_I2C4_CLK_SHIFT		19
-	#define SPEAR1310_I2C3_CLK_SHIFT		18
-	#define SPEAR1310_I2C2_CLK_SHIFT		17
-	#define SPEAR1310_I2C1_CLK_SHIFT		16
-	#define SPEAR1310_GPT64_CLK_RAS_48M_VAL		0
-	#define SPEAR1310_GPT64_CLK_PCLK_VAL		1
-	#define SPEAR1310_GPT64_CLK_MASK		1
-	#define SPEAR1310_GPT64_CLK_SHIFT		15
-	#define SPEAR1310_UART_CLK_PCLK_VAL		0
-	#define SPEAR1310_UART_CLK_RAS_CLK_SYNT3	1
-	#define SPEAR1310_RAS_UART_CLK_MASK		1
-	#define SPEAR1310_UART5_CLK_SHIFT		14
-	#define SPEAR1310_UART4_CLK_SHIFT		13
-	#define SPEAR1310_UART3_CLK_SHIFT		12
-	#define SPEAR1310_UART2_CLK_SHIFT		11
-	#define SPEAR1310_UART1_CLK_SHIFT		10
-	#define SPEAR1310_PMX_GMAC_PCI_SEL_MASK		9 /* 0: GMAC, 1: PCI */
-	#define SPEAR1310_PCI_EXT_ARBITER_ENB		(1 << 8)
-	#define SPEAR1310_PCI_BUS_INT_ENB		7
-	#define SPEAR1310_PCI_INTR_STATUS		6
-	#define SPEAR1310_PCI_INTRX_ENB			5 /* 0: enb, 1: dsb */
-	#define SPEAR1310_PCI_PWR_STATE_CHG_ACK		4 /* 1: can change */
-	#define SPEAR1310_PCI_PME_VOLT_LEVEL		3 /* 0: Vaux, 1: Vcc */
-	#define SPEAR1310_PCI_INT_ARBITER_ENB		(1 << 2)
-	#define SPEAR1310_PCI_PME_STATUS		1
-	#define SPEAR1310_PCI_CLK_PLL3_VAL		0
-	#define SPEAR1310_PCI_CLK_RAS_SYNT2_VAL		1
-	#define SPEAR1310_PCI_CLK_MASK			1
-	#define SPEAR1310_PCI_CLK_SHIFT			0
-
-#define SPEAR1310_RAS_CTRL_REG1			(VA_SPEAR1310_RAS_BASE + 0x004)
-	#define SPEAR1310_RAS_TX50M_VAL			0x0	/* Only RMII */
-	#define SPEAR1310_RAS_TX125M_PAD_VAL		0x1	/* Only SMII */
-	#define SPEAR1310_RAS_PLL2_VAL			0x2
-	#define SPEAR1310_RAS_SYNTH0_VAL		0x3
-	#define SPEAR1310_PHY_CLK_MASK			0x3
-	#define SPEAR1310_RMII_PHY_CLK_SHIFT		0
-	#define SPEAR1310_SMII_RGMII_PHY_CLK_SHIFT	2
-
-#define SPEAR1310_RAS_SW_CLK_CTRL		(VA_SPEAR1310_RAS_BASE + 0x0148)
-	#define SPEAR1310_CAN1_CLK_ENB			25
-	#define SPEAR1310_CAN0_CLK_ENB			24
-	#define SPEAR1310_GPT64_CLK_ENB			23
-	#define SPEAR1310_SSP1_CLK_ENB			22
-	#define SPEAR1310_I2C7_CLK_ENB			21
-	#define SPEAR1310_I2C6_CLK_ENB			20
-	#define SPEAR1310_I2C5_CLK_ENB			19
-	#define SPEAR1310_I2C4_CLK_ENB			18
-	#define SPEAR1310_I2C3_CLK_ENB			17
-	#define SPEAR1310_I2C2_CLK_ENB			16
-	#define SPEAR1310_I2C1_CLK_ENB			15
-	#define SPEAR1310_UART5_CLK_ENB			14
-	#define SPEAR1310_UART4_CLK_ENB			13
-	#define SPEAR1310_UART3_CLK_ENB			12
-	#define SPEAR1310_UART2_CLK_ENB			11
-	#define SPEAR1310_UART1_CLK_ENB			10
-	#define SPEAR1310_RS485_1_CLK_ENB		9
-	#define SPEAR1310_RS485_0_CLK_ENB		8
-	#define SPEAR1310_TDM2_CLK_ENB			7
-	#define SPEAR1310_TDM1_CLK_ENB			6
-	#define SPEAR1310_PCI_CLK_ENB			5
-	#define SPEAR1310_GMII_CLK_ENB			4
-	#define SPEAR1310_MII2_CLK_ENB			3
-	#define SPEAR1310_MII1_CLK_ENB			2
-	#define SPEAR1310_MII0_CLK_ENB			1
-	#define SPEAR1310_ESRAM_CLK_ENB			0
-
 #endif /* CONFIG_MACH_SPEAR1310 */
