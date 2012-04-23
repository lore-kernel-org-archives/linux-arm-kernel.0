From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Apr 2012 21:05:42 +0800
Subject: [PATCH 3/3] mtd: gpmi: add device tree support for mx6q-arm2 and
 mx28evk
In-Reply-To: <4F950E81.8040706@freescale.com>
References: <1334913859-5314-1-git-send-email-b32955@freescale.com>
 <1334913859-5314-4-git-send-email-b32955@freescale.com>
 <20120423064334.GQ26306@S2101-09.ap.freescale.net>
 <4F950E81.8040706@freescale.com>
Message-ID: <20120423130539.GT26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 04:10:41PM +0800, Huang Shijie wrote:
> Do you mean I can merge the gpmi and bch into one device node such as :
> 
> gpmi-nand at xx {
> compatible = "fsl, mx28-gpmi-nand";
> reg = <xx>, <xx>;
> reg-names = "gpmi", "bch";
> 
> };
> 
Yes.  But you need to redefine GPMI_NAND_GPMI_REGS_ADDR_RES_NAME as
"gpmi" and GPMI_NAND_BCH_REGS_ADDR_RES_NAME as "bch".  That said,
the strings here must match the ones used in driver.

-- 
Regards,
Shawn
