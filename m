From: lkp@intel.com (kbuild test robot)
Date: Tue, 10 Jul 2018 20:12:30 +0800
Subject: [PATCH 1/2] clk: imx: add ocram_s clock for i.mx6sx
In-Reply-To: <1531211979-2179-1-git-send-email-Anson.Huang@nxp.com>
References: <1531211979-2179-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <201807101932.aAfpy9CS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on v4.18-rc4 next-20180709]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Anson-Huang/clk-imx-add-ocram_s-clock-for-i-mx6sx/20180710-171526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/imx/clk-imx6sx.c:12:0:
>> include/dt-bindings/clock/imx6sx-clock.h:282:0: warning: "IMX6SX_CLK_OCRAM_S" redefined
    #define IMX6SX_CLK_OCRAM_S  269
    
   include/dt-bindings/clock/imx6sx-clock.h:170:0: note: this is the location of the previous definition
    #define IMX6SX_CLK_OCRAM_S  157
    

vim +/IMX6SX_CLK_OCRAM_S +282 include/dt-bindings/clock/imx6sx-clock.h

    12	
    13	#define IMX6SX_CLK_DUMMY		0
    14	#define IMX6SX_CLK_CKIL			1
    15	#define IMX6SX_CLK_CKIH			2
    16	#define IMX6SX_CLK_OSC			3
    17	#define IMX6SX_CLK_PLL1_SYS		4
    18	#define IMX6SX_CLK_PLL2_BUS		5
    19	#define IMX6SX_CLK_PLL3_USB_OTG		6
    20	#define IMX6SX_CLK_PLL4_AUDIO		7
    21	#define IMX6SX_CLK_PLL5_VIDEO		8
    22	#define IMX6SX_CLK_PLL6_ENET		9
    23	#define IMX6SX_CLK_PLL7_USB_HOST	10
    24	#define IMX6SX_CLK_USBPHY1		11
    25	#define IMX6SX_CLK_USBPHY2		12
    26	#define IMX6SX_CLK_USBPHY1_GATE		13
    27	#define IMX6SX_CLK_USBPHY2_GATE		14
    28	#define IMX6SX_CLK_PCIE_REF		15
    29	#define IMX6SX_CLK_PCIE_REF_125M	16
    30	#define IMX6SX_CLK_ENET_REF		17
    31	#define IMX6SX_CLK_PLL2_PFD0		18
    32	#define IMX6SX_CLK_PLL2_PFD1		19
    33	#define IMX6SX_CLK_PLL2_PFD2		20
    34	#define IMX6SX_CLK_PLL2_PFD3		21
    35	#define IMX6SX_CLK_PLL3_PFD0		22
    36	#define IMX6SX_CLK_PLL3_PFD1		23
    37	#define IMX6SX_CLK_PLL3_PFD2		24
    38	#define IMX6SX_CLK_PLL3_PFD3		25
    39	#define IMX6SX_CLK_PLL2_198M		26
    40	#define IMX6SX_CLK_PLL3_120M		27
    41	#define IMX6SX_CLK_PLL3_80M		28
    42	#define IMX6SX_CLK_PLL3_60M		29
    43	#define IMX6SX_CLK_TWD			30
    44	#define IMX6SX_CLK_PLL4_POST_DIV	31
    45	#define IMX6SX_CLK_PLL4_AUDIO_DIV	32
    46	#define IMX6SX_CLK_PLL5_POST_DIV	33
    47	#define IMX6SX_CLK_PLL5_VIDEO_DIV	34
    48	#define IMX6SX_CLK_STEP			35
    49	#define IMX6SX_CLK_PLL1_SW		36
    50	#define IMX6SX_CLK_OCRAM_SEL		37
    51	#define IMX6SX_CLK_PERIPH_PRE		38
    52	#define IMX6SX_CLK_PERIPH2_PRE		39
    53	#define IMX6SX_CLK_PERIPH_CLK2_SEL	40
    54	#define IMX6SX_CLK_PERIPH2_CLK2_SEL	41
    55	#define IMX6SX_CLK_PCIE_AXI_SEL		42
    56	#define IMX6SX_CLK_GPU_AXI_SEL		43
    57	#define IMX6SX_CLK_GPU_CORE_SEL		44
    58	#define IMX6SX_CLK_EIM_SLOW_SEL		45
    59	#define IMX6SX_CLK_USDHC1_SEL		46
    60	#define IMX6SX_CLK_USDHC2_SEL		47
    61	#define IMX6SX_CLK_USDHC3_SEL		48
    62	#define IMX6SX_CLK_USDHC4_SEL		49
    63	#define IMX6SX_CLK_SSI1_SEL		50
    64	#define IMX6SX_CLK_SSI2_SEL		51
    65	#define IMX6SX_CLK_SSI3_SEL		52
    66	#define IMX6SX_CLK_QSPI1_SEL		53
    67	#define IMX6SX_CLK_PERCLK_SEL		54
    68	#define IMX6SX_CLK_VID_SEL		55
    69	#define IMX6SX_CLK_ESAI_SEL		56
    70	#define IMX6SX_CLK_LDB_DI0_DIV_SEL	57
    71	#define IMX6SX_CLK_LDB_DI1_DIV_SEL	58
    72	#define IMX6SX_CLK_CAN_SEL		59
    73	#define IMX6SX_CLK_UART_SEL		60
    74	#define IMX6SX_CLK_QSPI2_SEL		61
    75	#define IMX6SX_CLK_LDB_DI1_SEL		62
    76	#define IMX6SX_CLK_LDB_DI0_SEL		63
    77	#define IMX6SX_CLK_SPDIF_SEL		64
    78	#define IMX6SX_CLK_AUDIO_SEL		65
    79	#define IMX6SX_CLK_ENET_PRE_SEL		66
    80	#define IMX6SX_CLK_ENET_SEL		67
    81	#define IMX6SX_CLK_M4_PRE_SEL		68
    82	#define IMX6SX_CLK_M4_SEL		69
    83	#define IMX6SX_CLK_ECSPI_SEL		70
    84	#define IMX6SX_CLK_LCDIF1_PRE_SEL	71
    85	#define IMX6SX_CLK_LCDIF2_PRE_SEL	72
    86	#define IMX6SX_CLK_LCDIF1_SEL		73
    87	#define IMX6SX_CLK_LCDIF2_SEL		74
    88	#define IMX6SX_CLK_DISPLAY_SEL		75
    89	#define IMX6SX_CLK_CSI_SEL		76
    90	#define IMX6SX_CLK_CKO1_SEL		77
    91	#define IMX6SX_CLK_CKO2_SEL		78
    92	#define IMX6SX_CLK_CKO			79
    93	#define IMX6SX_CLK_PERIPH_CLK2		80
    94	#define IMX6SX_CLK_PERIPH2_CLK2		81
    95	#define IMX6SX_CLK_IPG			82
    96	#define IMX6SX_CLK_GPU_CORE_PODF	83
    97	#define IMX6SX_CLK_GPU_AXI_PODF		84
    98	#define IMX6SX_CLK_LCDIF1_PODF		85
    99	#define IMX6SX_CLK_QSPI1_PODF		86
   100	#define IMX6SX_CLK_EIM_SLOW_PODF	87
   101	#define IMX6SX_CLK_LCDIF2_PODF		88
   102	#define IMX6SX_CLK_PERCLK		89
   103	#define IMX6SX_CLK_VID_PODF		90
   104	#define IMX6SX_CLK_CAN_PODF		91
   105	#define IMX6SX_CLK_USDHC1_PODF		92
   106	#define IMX6SX_CLK_USDHC2_PODF		93
   107	#define IMX6SX_CLK_USDHC3_PODF		94
   108	#define IMX6SX_CLK_USDHC4_PODF		95
   109	#define IMX6SX_CLK_UART_PODF		96
   110	#define IMX6SX_CLK_ESAI_PRED		97
   111	#define IMX6SX_CLK_ESAI_PODF		98
   112	#define IMX6SX_CLK_SSI3_PRED		99
   113	#define IMX6SX_CLK_SSI3_PODF		100
   114	#define IMX6SX_CLK_SSI1_PRED		101
   115	#define IMX6SX_CLK_SSI1_PODF		102
   116	#define IMX6SX_CLK_QSPI2_PRED		103
   117	#define IMX6SX_CLK_QSPI2_PODF		104
   118	#define IMX6SX_CLK_SSI2_PRED		105
   119	#define IMX6SX_CLK_SSI2_PODF		106
   120	#define IMX6SX_CLK_SPDIF_PRED		107
   121	#define IMX6SX_CLK_SPDIF_PODF		108
   122	#define IMX6SX_CLK_AUDIO_PRED		109
   123	#define IMX6SX_CLK_AUDIO_PODF		110
   124	#define IMX6SX_CLK_ENET_PODF		111
   125	#define IMX6SX_CLK_M4_PODF		112
   126	#define IMX6SX_CLK_ECSPI_PODF		113
   127	#define IMX6SX_CLK_LCDIF1_PRED		114
   128	#define IMX6SX_CLK_LCDIF2_PRED		115
   129	#define IMX6SX_CLK_DISPLAY_PODF		116
   130	#define IMX6SX_CLK_CSI_PODF		117
   131	#define IMX6SX_CLK_LDB_DI0_DIV_3_5	118
   132	#define IMX6SX_CLK_LDB_DI0_DIV_7	119
   133	#define IMX6SX_CLK_LDB_DI1_DIV_3_5	120
   134	#define IMX6SX_CLK_LDB_DI1_DIV_7	121
   135	#define IMX6SX_CLK_CKO1_PODF		122
   136	#define IMX6SX_CLK_CKO2_PODF		123
   137	#define IMX6SX_CLK_PERIPH		124
   138	#define IMX6SX_CLK_PERIPH2		125
   139	#define IMX6SX_CLK_OCRAM		126
   140	#define IMX6SX_CLK_AHB			127
   141	#define IMX6SX_CLK_MMDC_PODF		128
   142	#define IMX6SX_CLK_ARM			129
   143	#define IMX6SX_CLK_AIPS_TZ1		130
   144	#define IMX6SX_CLK_AIPS_TZ2		131
   145	#define IMX6SX_CLK_APBH_DMA		132
   146	#define IMX6SX_CLK_ASRC_GATE		133
   147	#define IMX6SX_CLK_CAAM_MEM		134
   148	#define IMX6SX_CLK_CAAM_ACLK		135
   149	#define IMX6SX_CLK_CAAM_IPG		136
   150	#define IMX6SX_CLK_CAN1_IPG		137
   151	#define IMX6SX_CLK_CAN1_SERIAL		138
   152	#define IMX6SX_CLK_CAN2_IPG		139
   153	#define IMX6SX_CLK_CAN2_SERIAL		140
   154	#define IMX6SX_CLK_CPU_DEBUG		141
   155	#define IMX6SX_CLK_DCIC1		142
   156	#define IMX6SX_CLK_DCIC2		143
   157	#define IMX6SX_CLK_AIPS_TZ3		144
   158	#define IMX6SX_CLK_ECSPI1		145
   159	#define IMX6SX_CLK_ECSPI2		146
   160	#define IMX6SX_CLK_ECSPI3		147
   161	#define IMX6SX_CLK_ECSPI4		148
   162	#define IMX6SX_CLK_ECSPI5		149
   163	#define IMX6SX_CLK_EPIT1		150
   164	#define IMX6SX_CLK_EPIT2		151
   165	#define IMX6SX_CLK_ESAI_EXTAL		152
   166	#define IMX6SX_CLK_WAKEUP		153
   167	#define IMX6SX_CLK_GPT_BUS		154
   168	#define IMX6SX_CLK_GPT_SERIAL		155
   169	#define IMX6SX_CLK_GPU			156
   170	#define IMX6SX_CLK_OCRAM_S		157
   171	#define IMX6SX_CLK_CANFD		158
   172	#define IMX6SX_CLK_CSI			159
   173	#define IMX6SX_CLK_I2C1			160
   174	#define IMX6SX_CLK_I2C2			161
   175	#define IMX6SX_CLK_I2C3			162
   176	#define IMX6SX_CLK_OCOTP		163
   177	#define IMX6SX_CLK_IOMUXC		164
   178	#define IMX6SX_CLK_IPMUX1		165
   179	#define IMX6SX_CLK_IPMUX2		166
   180	#define IMX6SX_CLK_IPMUX3		167
   181	#define IMX6SX_CLK_TZASC1		168
   182	#define IMX6SX_CLK_LCDIF_APB		169
   183	#define IMX6SX_CLK_PXP_AXI		170
   184	#define IMX6SX_CLK_M4			171
   185	#define IMX6SX_CLK_ENET			172
   186	#define IMX6SX_CLK_DISPLAY_AXI		173
   187	#define IMX6SX_CLK_LCDIF2_PIX		174
   188	#define IMX6SX_CLK_LCDIF1_PIX		175
   189	#define IMX6SX_CLK_LDB_DI0		176
   190	#define IMX6SX_CLK_QSPI1		177
   191	#define IMX6SX_CLK_MLB			178
   192	#define IMX6SX_CLK_MMDC_P0_FAST		179
   193	#define IMX6SX_CLK_MMDC_P0_IPG		180
   194	#define IMX6SX_CLK_AXI			181
   195	#define IMX6SX_CLK_PCIE_AXI		182
   196	#define IMX6SX_CLK_QSPI2		183
   197	#define IMX6SX_CLK_PER1_BCH		184
   198	#define IMX6SX_CLK_PER2_MAIN		185
   199	#define IMX6SX_CLK_PWM1			186
   200	#define IMX6SX_CLK_PWM2			187
   201	#define IMX6SX_CLK_PWM3			188
   202	#define IMX6SX_CLK_PWM4			189
   203	#define IMX6SX_CLK_GPMI_BCH_APB		190
   204	#define IMX6SX_CLK_GPMI_BCH		191
   205	#define IMX6SX_CLK_GPMI_IO		192
   206	#define IMX6SX_CLK_GPMI_APB		193
   207	#define IMX6SX_CLK_ROM			194
   208	#define IMX6SX_CLK_SDMA			195
   209	#define IMX6SX_CLK_SPBA			196
   210	#define IMX6SX_CLK_SPDIF		197
   211	#define IMX6SX_CLK_SSI1_IPG		198
   212	#define IMX6SX_CLK_SSI2_IPG		199
   213	#define IMX6SX_CLK_SSI3_IPG		200
   214	#define IMX6SX_CLK_SSI1			201
   215	#define IMX6SX_CLK_SSI2			202
   216	#define IMX6SX_CLK_SSI3			203
   217	#define IMX6SX_CLK_UART_IPG		204
   218	#define IMX6SX_CLK_UART_SERIAL		205
   219	#define IMX6SX_CLK_SAI1			206
   220	#define IMX6SX_CLK_SAI2			207
   221	#define IMX6SX_CLK_USBOH3		208
   222	#define IMX6SX_CLK_USDHC1		209
   223	#define IMX6SX_CLK_USDHC2		210
   224	#define IMX6SX_CLK_USDHC3		211
   225	#define IMX6SX_CLK_USDHC4		212
   226	#define IMX6SX_CLK_EIM_SLOW		213
   227	#define IMX6SX_CLK_PWM8			214
   228	#define IMX6SX_CLK_VADC			215
   229	#define IMX6SX_CLK_GIS			216
   230	#define IMX6SX_CLK_I2C4			217
   231	#define IMX6SX_CLK_PWM5			218
   232	#define IMX6SX_CLK_PWM6			219
   233	#define IMX6SX_CLK_PWM7			220
   234	#define IMX6SX_CLK_CKO1			221
   235	#define IMX6SX_CLK_CKO2			222
   236	#define IMX6SX_CLK_IPP_DI0		223
   237	#define IMX6SX_CLK_IPP_DI1		224
   238	#define IMX6SX_CLK_ENET_AHB		225
   239	#define IMX6SX_CLK_OCRAM_PODF		226
   240	#define IMX6SX_CLK_GPT_3M		227
   241	#define IMX6SX_CLK_ENET_PTP		228
   242	#define IMX6SX_CLK_ENET_PTP_REF		229
   243	#define IMX6SX_CLK_ENET2_REF		230
   244	#define IMX6SX_CLK_ENET2_REF_125M	231
   245	#define IMX6SX_CLK_AUDIO		232
   246	#define IMX6SX_CLK_LVDS1_SEL		233
   247	#define IMX6SX_CLK_LVDS1_OUT		234
   248	#define IMX6SX_CLK_ASRC_IPG		235
   249	#define IMX6SX_CLK_ASRC_MEM		236
   250	#define IMX6SX_CLK_SAI1_IPG		237
   251	#define IMX6SX_CLK_SAI2_IPG		238
   252	#define IMX6SX_CLK_ESAI_IPG		239
   253	#define IMX6SX_CLK_ESAI_MEM		240
   254	#define IMX6SX_CLK_LVDS1_IN		241
   255	#define IMX6SX_CLK_ANACLK1		242
   256	#define IMX6SX_PLL1_BYPASS_SRC		243
   257	#define IMX6SX_PLL2_BYPASS_SRC		244
   258	#define IMX6SX_PLL3_BYPASS_SRC		245
   259	#define IMX6SX_PLL4_BYPASS_SRC		246
   260	#define IMX6SX_PLL5_BYPASS_SRC		247
   261	#define IMX6SX_PLL6_BYPASS_SRC		248
   262	#define IMX6SX_PLL7_BYPASS_SRC		249
   263	#define IMX6SX_CLK_PLL1			250
   264	#define IMX6SX_CLK_PLL2			251
   265	#define IMX6SX_CLK_PLL3			252
   266	#define IMX6SX_CLK_PLL4			253
   267	#define IMX6SX_CLK_PLL5			254
   268	#define IMX6SX_CLK_PLL6			255
   269	#define IMX6SX_CLK_PLL7			256
   270	#define IMX6SX_PLL1_BYPASS		257
   271	#define IMX6SX_PLL2_BYPASS		258
   272	#define IMX6SX_PLL3_BYPASS		259
   273	#define IMX6SX_PLL4_BYPASS		260
   274	#define IMX6SX_PLL5_BYPASS		261
   275	#define IMX6SX_PLL6_BYPASS		262
   276	#define IMX6SX_PLL7_BYPASS		263
   277	#define IMX6SX_CLK_SPDIF_GCLK		264
   278	#define IMX6SX_CLK_LVDS2_SEL		265
   279	#define IMX6SX_CLK_LVDS2_OUT		266
   280	#define IMX6SX_CLK_LVDS2_IN		267
   281	#define IMX6SX_CLK_ANACLK2		268
 > 282	#define IMX6SX_CLK_OCRAM_S		269
   283	#define IMX6SX_CLK_CLK_END		270
   284	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66168 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/90ee8d98/attachment-0001.gz>
