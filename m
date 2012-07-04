From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 4 Jul 2012 21:25:26 +0800
Subject: [PATCH] ARM: imx: Fix build error due to missing irqs.h include
In-Reply-To: <20120704095302.GK16319@n2100.arm.linux.org.uk>
References: <1341365144-4549-1-git-send-email-festevam@gmail.com>
 <20120704033018.GA1862@S2100-06.ap.freescale.net>
 <20120704095302.GK16319@n2100.arm.linux.org.uk>
Message-ID: <20120704132523.GA2595@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 10:53:02AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 04, 2012 at 11:30:22AM +0800, Shawn Guo wrote:
> > Dammit.  I forgot testing imx_v4_v5_defconfig again with the last FIQ
> > change.  Thanks, Fabio.
> 
> So, this begs the question - which configs have you tested this series with?

For the patch changing FIQ_START to variable, I tested the following
defconfigs.

rpc_defconfig
s3c2410_defconfig
imx_v6_v7_defconfig

As avic.c is built with imx_v6_v7_defconfig as well, I thought it's
been covered there.  But it turns out that CONFIG_FIQ is not enabled
by imx_v6_v7_defconfig in any way, while it's enabled for
imx_v4_v5_defconfig because there are a couple of imx_v4_v5 audio
drivers selecting the symbol.

sound/soc/fsl/Kconfig:

config SND_SOC_IMX_PCM_FIQ
        tristate
        select FIQ
        select SND_SOC_IMX_PCM

-- 
Regards,
Shawn
