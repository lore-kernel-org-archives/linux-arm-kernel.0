From: Alison_Chaiken@mentor.com (Chaiken, Alison)
Date: Fri, 24 May 2013 17:51:42 +0000
Subject: [PATCH v3 5/6] ARM: dts: imx6dl: add pinctrls for WEIM NOR
In-Reply-To: <1369389564-13181-6-git-send-email-b32955@freescale.com>
References: <1369389564-13181-1-git-send-email-b32955@freescale.com>,
 <1369389564-13181-6-git-send-email-b32955@freescale.com>
Message-ID: <60BA5429A0E1584BA3633194F6F993B5025754D1@NA-MBX-03.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Huang Shijie, sorry for not catching this earlier, but based on my reading of Table 4-1 of Rev. 1 of IMX6DQRM, I would use the following:

  pinctrl_weim_nor_1: weim_norgrp-2 {
                                               fsl,pins = <

[ . . . ]
                                                       /* data */
                                                       MX6DL_PAD_EIM_D16__EIM_DATA16 0x1b0b0
                                                       MX6DL_PAD_EIM_D17__EIM_DATA17 0x1b0b0
                                                       MX6DL_PAD_EIM_D18__EIM_DATA18 0x1b0b0
                                                       MX6DL_PAD_EIM_D19__EIM_DATA19 0x1b0b0
                                                       MX6DL_PAD_EIM_D20__EIM_DATA20 0x1b0b0
                                                       MX6DL_PAD_EIM_D21__EIM_DATA21 0x1b0b0
                                                       MX6DL_PAD_EIM_D22__EIM_DATA22 0x1b0b0
                                                       MX6DL_PAD_EIM_D23__EIM_DATA23 0x1b0b0
                                                       MX6DL_PAD_EIM_D24__EIM_DATA24 0x1b0b0
                                                       MX6DL_PAD_EIM_D25__EIM_DATA25 0x1b0b0
                                                       MX6DL_PAD_EIM_D26__EIM_DATA26 0x1b0b0
                                                       MX6DL_PAD_EIM_D27__EIM_DATA27 0x1b0b0
                                                       MX6DL_PAD_EIM_D28__EIM_DATA28 0x1b0b0
                                                       MX6DL_PAD_EIM_D29__EIM_DATA29 0x1b0b0
                                                       MX6DL_PAD_EIM_D30__EIM_DATA30 0x1b0b0
                                                       MX6DL_PAD_EIM_D31__EIM_DATA31 0x1b0b0

[ .  .  . ]

                                               >;
                                       }; 

In your patch, the address lines are set to 0xb0b1, which is correct, as hysteresis is disabled and SRE is fast for those lines.     However, for data lines, hysteresis is enabled and SRE is slow, so the 0x1b0b0 setting is more appropriate.   

-- 
Alison Chaiken
Mentor Embedded Software Division
alison_chaiken at mentor.com
