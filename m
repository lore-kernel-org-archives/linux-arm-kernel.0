From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 10 Mar 2011 14:42:48 +0800
Subject: [PATCH V1] mx51 enchance the sd/mmc HW timing compatibility on
	mx51 boards.
In-Reply-To: <1299737746-19324-1-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1299737746-19324-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20110310064247.GH2556@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 02:15:46PM +0800, Richard Zhu wrote:
> Some cards have the CRC errors in read on mx51 BBG board.
> Configure the eSDHC pad configurations to level up the
> compatibility to fix this issue.
> 
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> Tested-by: Shawn Guo <shawn.gsc@gmail.com>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |   40 +++++++++++++-------------
>  1 files changed, 20 insertions(+), 20 deletions(-)
> 
This is a fix for the regression introduced by:

commit ee1ae4d7b1c9a8b73e232fa33dc733be59368ff6
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Wed Dec 15 09:56:35 2010 +0100

    ARM i.MX51: Full iomux support

    This iomux file has been constructed from the Freescale pinmux tool.
    It contains all pins from the tool, but the datasheet lists some
    configurations not present in the tool, these are not yet added.

Richard,

If there is v2, please change Tested-by as below.

Tested-by: Shawn Guo <shawn.guo@freescale.com>

-- 
Regards,
Shawn
