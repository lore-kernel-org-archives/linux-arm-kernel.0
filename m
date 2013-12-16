From: vaibhav.bedia@gmail.com (Vaibhav Bedia)
Date: Mon, 16 Dec 2013 08:27:17 -0500
Subject: [PATCH 1/2] ARM: EXYNOS: Support Suspend-to-RAM on EXYNOS5420
In-Reply-To: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
References: <1387195271-3613-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CANacCWx7YV45mVK=7BJjc95cSgm6ck1qSMRsfW3oeGxLC1LC5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 16, 2013 at 7:01 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
[...]
> +/* For EXYNOS5420 */
> +#define EXYNOS5420_CLKSRC_MASK_CPERI           EXYNOS_CLKREG(0x04300)
> +#define EXYNOS5420_CLKSRC_MASK_TOP0            EXYNOS_CLKREG(0x10300)
> +#define EXYNOS5420_CLKSRC_MASK_TOP1            EXYNOS_CLKREG(0x10304)
> +#define EXYNOS5420_CLKSRC_MASK_TOP2            EXYNOS_CLKREG(0x10308)
> +#define EXYNOS5420_CLKSRC_MASK_TOP7            EXYNOS_CLKREG(0x1031C)
> +#define EXYNOS5420_CLKSRC_MASK_DISP10          EXYNOS_CLKREG(0x1032C)
> +#define EXYNOS5420_CLKSRC_MASK_MAU             EXYNOS_CLKREG(0x10334)
> +#define EXYNOS5420_CLKSRC_MASK_FSYS            EXYNOS_CLKREG(0x10340)
> +#define EXYNOS5420_CLKSRC_MASK_PERIC0          EXYNOS_CLKREG(0x10350)
> +#define EXYNOS5420_CLKSRC_MASK_PERIC1          EXYNOS_CLKREG(0x10354)
> +#define EXYNOS5420_CLKSRC_MASK_ISP             EXYNOS_CLKREG(0x10370)
> +#define EXYNOS5420_CLKGATE_BUS_DISP1           EXYNOS_CLKREG(0x10728)
> +#define EXYNOS5420_CLKGATE_IP_PERIC            EXYNOS_CLKREG(0x10950)
> +

[...]

> +#define EXYNOS5420_IROM_DATA2                                  S5P_PMUREG(0x0988)
> +#define EXYNOS5420_ARM_CORE2_SYS_PWR_REG                       S5P_PMUREG(0x1020)
> +#define EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG         S5P_PMUREG(0x1024)
> +#define EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG       S5P_PMUREG(0x1028)
> +#define EXYNOS5420_ARM_CORE3_SYS_PWR_REG                       S5P_PMUREG(0x1030)
> +#define EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG         S5P_PMUREG(0x1034)
> +#define EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG       S5P_PMUREG(0x1038)
> +#define EXYNOS5420_KFC_CORE0_SYS_PWR_REG                       S5P_PMUREG(0x1040)
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG         S5P_PMUREG(0x1044)
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG       S5P_PMUREG(0x1048)
> +#define EXYNOS5420_KFC_CORE1_SYS_PWR_REG                       S5P_PMUREG(0x1050)
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG         S5P_PMUREG(0x1054)
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG       S5P_PMUREG(0x1058)
> +#define EXYNOS5420_KFC_CORE2_SYS_PWR_REG                       S5P_PMUREG(0x1060)
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG         S5P_PMUREG(0x1064)
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG       S5P_PMUREG(0x1068)
> +#define EXYNOS5420_KFC_CORE3_SYS_PWR_REG                       S5P_PMUREG(0x1070)
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG         S5P_PMUREG(0x1074)
> +#define EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG       S5P_PMUREG(0x1078)
> +#define EXYNOS5420_ISP_ARM_SYS_PWR_REG                         S5P_PMUREG(0x1090)
> +#define EXYNOS5420_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG           S5P_PMUREG(0x1094)
> +#define EXYNOS5420_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG         S5P_PMUREG(0x1098)
> +#define EXYNOS5420_ARM_COMMON_SYS_PWR_REG                      S5P_PMUREG(0x10A0)
> +#define EXYNOS5420_KFC_COMMON_SYS_PWR_REG                      S5P_PMUREG(0x10B0)
> +#define EXYNOS5420_KFC_L2_SYS_PWR_REG                          S5P_PMUREG(0x10D0)
> +#define EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG                     S5P_PMUREG(0x1158)
> +#define EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG                     S5P_PMUREG(0x115C)
> +#define EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG                     S5P_PMUREG(0x1160)
> +#define EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG                     S5P_PMUREG(0x1174)
> +#define EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG                     S5P_PMUREG(0x1178)
> +#define EXYNOS5420_INTRAM_MEM_SYS_PWR_REG                      S5P_PMUREG(0x11B8)
> +#define EXYNOS5420_INTROM_MEM_SYS_PWR_REG                      S5P_PMUREG(0x11BC)
> +#define EXYNOS5420_ONENANDXL_MEM_SYS_PWR                       S5P_PMUREG(0x11C0)
> +#define EXYNOS5420_USBDEV_MEM_SYS_PWR                          S5P_PMUREG(0x11CC)
> +#define EXYNOS5420_USBDEV1_MEM_SYS_PWR                         S5P_PMUREG(0x11D0)
> +#define EXYNOS5420_SDMMC_MEM_SYS_PWR                           S5P_PMUREG(0x11D4)
> +#define EXYNOS5420_CSSYS_MEM_SYS_PWR                           S5P_PMUREG(0x11D8)
> +#define EXYNOS5420_SECSS_MEM_SYS_PWR                           S5P_PMUREG(0x11DC)
> +#define EXYNOS5420_ROTATOR_MEM_SYS_PWR                         S5P_PMUREG(0x11E0)
> +#define EXYNOS5420_INTRAM_MEM_SYS_PWR                          S5P_PMUREG(0x11E4)
> +#define EXYNOS5420_INTROM_MEM_SYS_PWR                          S5P_PMUREG(0x11E8)
> +#define EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG              S5P_PMUREG(0x1208)
> +#define EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG              S5P_PMUREG(0x1210)
> +#define EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG              S5P_PMUREG(0x1214)
> +#define EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG              S5P_PMUREG(0x1218)
> +#define EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG              S5P_PMUREG(0x121C)
> +#define EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG              S5P_PMUREG(0x1220)
> +#define EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG               S5P_PMUREG(0x1224)
> +#define EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG              S5P_PMUREG(0x1228)
> +#define EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG              S5P_PMUREG(0x122C)
> +#define EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG               S5P_PMUREG(0x1230)
> +#define EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG      S5P_PMUREG(0x1234)
> +#define EXYNOS5420_DISP1_SYS_PWR_REG                           S5P_PMUREG(0x1410)
> +#define EXYNOS5420_MAU_SYS_PWR_REG                             S5P_PMUREG(0x1414)
> +#define EXYNOS5420_G2D_SYS_PWR_REG                             S5P_PMUREG(0x1418)
> +#define EXYNOS5420_MSC_SYS_PWR_REG                             S5P_PMUREG(0x141C)
> +#define EXYNOS5420_FSYS_SYS_PWR_REG                            S5P_PMUREG(0x1420)
> +#define EXYNOS5420_FSYS2_SYS_PWR_REG                           S5P_PMUREG(0x1424)
> +#define EXYNOS5420_PSGEN_SYS_PWR_REG                           S5P_PMUREG(0x1428)
> +#define EXYNOS5420_PERIC_SYS_PWR_REG                           S5P_PMUREG(0x142C)
> +#define EXYNOS5420_WCORE_SYS_PWR_REG                           S5P_PMUREG(0x1430)
>  #define EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG               S5P_PMUREG(0x1490)
>  #define EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG                 S5P_PMUREG(0x1494)
>  #define EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG                 S5P_PMUREG(0x1498)
> @@ -402,6 +465,7 @@
>  #define EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG                   S5P_PMUREG(0x1598)
>  #define EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG                   S5P_PMUREG(0x159C)
>  #define EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG                  S5P_PMUREG(0x15A0)
> +#define EXYNOS5420_SFR_AXI_CGDIS1                              S5P_PMUREG(0x15E4)
>  #define EXYNOS5420_ARM_COMMON_STATUS                           S5P_PMUREG(0x2504)
>  #define EXYNOS5420_ARM_COMMON_OPTION                           S5P_PMUREG(0x2508)
>  #define EXYNOS5420_KFC_COMMON_STATUS                           S5P_PMUREG(0x2584)
> @@ -410,7 +474,24 @@
>  #define EXYNOS5420_KFC_L2_OPTION                               S5P_PMUREG(0x2688)
>  #define EXYNOS5420_LOGIC_RESET_DURATION3                       S5P_PMUREG(0x2D1C)
>
> +#define EXYNOS5420_PAD_RET_DRAM_OPTION                         S5P_PMUREG(0x3008)
> +#define EXYNOS5420_PAD_RET_MAUDIO_OPTION                       S5P_PMUREG(0x3028)
> +#define EXYNOS5420_PAD_RET_JTAG_OPTION                         S5P_PMUREG(0x3048)
> +#define EXYNOS5420_PAD_RET_GPIO_OPTION                         S5P_PMUREG(0x30C8)
> +#define EXYNOS5420_PAD_RET_UART_OPTION                         S5P_PMUREG(0x30E8)
> +#define EXYNOS5420_PAD_RET_MMCA_OPTION                         S5P_PMUREG(0x3108)
> +#define EXYNOS5420_PAD_RET_MMCB_OPTION                         S5P_PMUREG(0x3128)
> +#define EXYNOS5420_PAD_RET_MMCC_OPTION                         S5P_PMUREG(0x3148)
> +#define EXYNOS5420_PAD_RET_HSI_OPTION                          S5P_PMUREG(0x3168)
> +#define EXYNOS5420_PAD_RET_EBIA_OPTION                         S5P_PMUREG(0x3188)
> +#define EXYNOS5420_PAD_RET_EBIB_OPTION                         S5P_PMUREG(0x31A8)
> +#define EXYNOS5420_PAD_RET_SPI_OPTION                          S5P_PMUREG(0x31C8)
> +#define EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION                 S5P_PMUREG(0x31E8)
> +
> +

[...]

>
> +static struct exynos_pmu_conf exynos5420_pmu_config[] = {
> +       /* { .reg = address, .val = { AFTR, LPA, SLEEP } */
> +       { EXYNOS5_ARM_CORE0_SYS_PWR_REG,                        { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ARM_CORE0_LOCAL_SYS_PWR_REG,          { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ARM_CORE0_CENTRAL_SYS_PWR_REG,        { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_ARM_CORE1_SYS_PWR_REG,                        { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ARM_CORE1_LOCAL_SYS_PWR_REG,          { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ARM_CORE1_CENTRAL_SYS_PWR_REG,        { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_ARM_CORE2_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_ARM_CORE2_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_ARM_CORE2_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_ARM_CORE3_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_ARM_CORE3_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_ARM_CORE3_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_CORE0_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE0_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE0_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_CORE1_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE1_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE1_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_CORE2_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE2_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE2_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_CORE3_SYS_PWR_REG,                     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE3_LOCAL_SYS_PWR_REG,       { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_DIS_IRQ_KFC_CORE3_CENTRAL_SYS_PWR_REG,     { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_ISP_ARM_SYS_PWR_REG,                          { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ISP_ARM_LOCAL_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_DIS_IRQ_ISP_ARM_CENTRAL_SYS_PWR_REG,          { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_ARM_COMMON_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_COMMON_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_ARM_L2_SYS_PWR_REG,                           { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_KFC_L2_SYS_PWR_REG,                        { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_ACLKSTOP_SYS_PWR_REG,                     { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SCLKSTOP_SYS_PWR_REG,                     { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_CMU_RESET_SYS_PWR_REG,                        { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_CMU_ACLKSTOP_SYSMEM_SYS_PWR_REG,              { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SCLKSTOP_SYSMEM_SYS_PWR_REG,              { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_CMU_RESET_SYSMEM_SYS_PWR_REG,                 { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_DRAM_FREQ_DOWN_SYS_PWR_REG,                   { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_DDRPHY_DLLOFF_SYS_PWR_REG,                    { 0x1, 0x1, 0x1} },
> +       { EXYNOS5_DDRPHY_DLLLOCK_SYS_PWR_REG,                   { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_APLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_MPLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_VPLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_EPLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_BPLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_CPLL_SYSCLK_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_DPLL_SYSCLK_SYS_PWR_REG,                   { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_IPLL_SYSCLK_SYS_PWR_REG,                   { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_KPLL_SYSCLK_SYS_PWR_REG,                   { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_MPLLUSER_SYSCLK_SYS_PWR_REG,                  { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_BPLLUSER_SYSCLK_SYS_PWR_REG,                  { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_RPLL_SYSCLK_SYS_PWR_REG,                   { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_SPLL_SYSCLK_SYS_PWR_REG,                   { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_TOP_BUS_SYS_PWR_REG,                          { 0x3, 0x0, 0x0} },
> +       { EXYNOS5_TOP_RETENTION_SYS_PWR_REG,                    { 0x1, 0x1, 0x1} },
> +       { EXYNOS5_TOP_PWR_SYS_PWR_REG,                          { 0x3, 0x3, 0x0} },
> +       { EXYNOS5_TOP_BUS_SYSMEM_SYS_PWR_REG,                   { 0x3, 0x0, 0x0} },
> +       { EXYNOS5_TOP_RETENTION_SYSMEM_SYS_PWR_REG,             { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_TOP_PWR_SYSMEM_SYS_PWR_REG,                   { 0x3, 0x0, 0x0} },
> +       { EXYNOS5_LOGIC_RESET_SYS_PWR_REG,                      { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_OSCCLK_GATE_SYS_PWR_REG,                      { 0x1, 0x0, 0x1} },
> +       { EXYNOS5_LOGIC_RESET_SYSMEM_SYS_PWR_REG,               { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_OSCCLK_GATE_SYSMEM_SYS_PWR_REG,               { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_INTRAM_MEM_SYS_PWR_REG,                    { 0x3, 0x0, 0x3} },
> +       { EXYNOS5420_INTROM_MEM_SYS_PWR_REG,                    { 0x3, 0x0, 0x3} },
> +       { EXYNOS5_PAD_RETENTION_DRAM_SYS_PWR_REG,               { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_PAD_RETENTION_MAU_SYS_PWR_REG,                { 0x1, 0x1, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_JTAG_SYS_PWR_REG,            { 0x1, 0x1, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_DRAM_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_UART_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_MMC0_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_MMC1_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_MMC2_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_HSI_SYS_PWR_REG,             { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_EBIA_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_EBIB_SYS_PWR_REG,            { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_SPI_SYS_PWR_REG,             { 0x1, 0x0, 0x0} },
> +       { EXYNOS5420_PAD_RETENTION_DRAM_COREBLK_SYS_PWR_REG,    { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_PAD_ISOLATION_SYS_PWR_REG,                    { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_PAD_ISOLATION_SYSMEM_SYS_PWR_REG,             { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_PAD_ALV_SEL_SYS_PWR_REG,                      { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_XUSBXTI_SYS_PWR_REG,                          { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_XXTI_SYS_PWR_REG,                             { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_EXT_REGULATOR_SYS_PWR_REG,                    { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_GPIO_MODE_SYS_PWR_REG,                        { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_GPIO_MODE_SYSMEM_SYS_PWR_REG,                 { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_GPIO_MODE_MAU_SYS_PWR_REG,                    { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_TOP_ASB_RESET_SYS_PWR_REG,                    { 0x1, 0x1, 0x0} },
> +       { EXYNOS5_TOP_ASB_ISOLATION_SYS_PWR_REG,                { 0x1, 0x0, 0x0} },
> +       { EXYNOS5_GSCL_SYS_PWR_REG,                             { 0x7, 0x0, 0x0} },
> +       { EXYNOS5_ISP_SYS_PWR_REG,                              { 0x7, 0x0, 0x0} },
> +       { EXYNOS5_MFC_SYS_PWR_REG,                              { 0x7, 0x0, 0x0} },
> +       { EXYNOS5_G3D_SYS_PWR_REG,                              { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_DISP1_SYS_PWR_REG,                         { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_MAU_SYS_PWR_REG,                           { 0x7, 0x7, 0x0} },
> +       { EXYNOS5420_G2D_SYS_PWR_REG,                           { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_MSC_SYS_PWR_REG,                           { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_FSYS_SYS_PWR_REG,                          { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_FSYS2_SYS_PWR_REG,                         { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_PSGEN_SYS_PWR_REG,                         { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_PERIC_SYS_PWR_REG,                         { 0x7, 0x0, 0x0} },
> +       { EXYNOS5420_WCORE_SYS_PWR_REG,                         { 0x7, 0x0, 0x0} },
> +       { EXYNOS5_CMU_CLKSTOP_GSCL_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_CLKSTOP_ISP_SYS_PWR_REG,                  { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_CLKSTOP_MFC_SYS_PWR_REG,                  { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_CLKSTOP_G3D_SYS_PWR_REG,                  { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_DISP1_SYS_PWR_REG,             { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_MAU_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_G2D_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_MSC_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_FSYS_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_PSGEN_SYS_PWR_REG,             { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_PERIC_SYS_PWR_REG,             { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_CLKSTOP_WCORE_SYS_PWR_REG,             { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SYSCLK_GSCL_SYS_PWR_REG,                  { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SYSCLK_ISP_SYS_PWR_REG,                   { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SYSCLK_MFC_SYS_PWR_REG,                   { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_SYSCLK_G3D_SYS_PWR_REG,                   { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_DISP1_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_MAU_SYS_PWR_REG,                { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_G2D_SYS_PWR_REG,                { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_MSC_SYS_PWR_REG,                { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_FSYS_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_FSYS2_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_PSGEN_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_PERIC_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_SYSCLK_WCORE_SYS_PWR_REG,              { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_FSYS2_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_PSGEN_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_PERIC_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_WCORE_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_RESET_GSCL_SYS_PWR_REG,                   { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_RESET_ISP_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_RESET_MFC_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> +       { EXYNOS5_CMU_RESET_G3D_SYS_PWR_REG,                    { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_DISP1_SYS_PWR_REG,               { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_MAU_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_G2D_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_MSC_SYS_PWR_REG,                 { 0x0, 0x0, 0x0} },
> +       { EXYNOS5420_CMU_RESET_FSYS_SYS_PWR_REG,                { 0x0, 0x0, 0x0} },
> +       { PMU_TABLE_END,},
> +};
> +

Looking at a rather long list of register defines and soc_is_* checks here
makes me wonder how this is any different from the static data that the
other SoC vendors (TI) are trying very hard to move out of arch/arm...
