From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 22:07:19 +0800
Subject: [PATCH] MXS: Enable FLEXCAN for MXS/DT
In-Reply-To: <4FE9A04F.8030109@pengutronix.de>
References: <1338084709-12043-1-git-send-email-marex@denx.de>
 <4FE97B12.8040306@pengutronix.de> <4FE97BCC.7050904@pengutronix.de>
 <20120626112804.GC8858@S2101-09.ap.freescale.net>
 <4FE9A04F.8030109@pengutronix.de>
Message-ID: <20120626140717.GB9294@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 01:43:11PM +0200, Marc Kleine-Budde wrote:
> Yes, but the HAVE_CAN_FLEXCAN is used to make the driver available in
> Kconfig. What about removing the "depends on HAVE_CAN_FLEXCAN" from the
> driver symbol in Kconfig? I can push it via net-next and it will be
> mainline in 3.6. You can remove the HAVE_CAN_FLEXCAN from the ARM (and
> powerpc) trees.
> 
Ok, that works for me if you would like to have the CAN_FLEXCAN show
up anyway for all the ARCHs, but otherwise we just end up with replacing
"depends on HAVE_CAN_FLEXCAN" with "depends on ARCH_MXS || ARCH_MXC".

-- 
Regards,
Shawn
