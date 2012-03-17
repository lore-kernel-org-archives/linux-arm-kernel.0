From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 17 Mar 2012 08:21:30 +0800
Subject: [PATCH v5 2/8] ASoC: imx: merge sound/soc/imx into sound/soc/fsl
In-Reply-To: <4F63AEE7.4030505@freescale.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
 <1331888204-27058-3-git-send-email-shawn.guo@linaro.org>
 <4F63AEE7.4030505@freescale.com>
Message-ID: <20120317002128.GC7860@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 04:21:43PM -0500, Timur Tabi wrote:
> Shawn Guo wrote:
> > Freescale PowerPC and ARM/IMX families share the same SSI IP block.
> > The patch merges sound/soc/imx into sound/soc/fsl, so that the possible
> > code sharing and consolidation can happen.
> > 
> > This is a plain merge, except that menuconfig SND_POWERPC_SOC is added
> > in Kconfig for PowerPC platform as a correspondence to SND_IMX_SOC for
> > IMX platform.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> 
> I'm okay with this patch, but you will need an Ack from Kumar Gala to
> carry the defconfig portions through the ASoC tree.  Or, he might want you
> to split the patch up.
> 
Splitting the patch up will introduce a dependency between PowerPC tree
and sound tree.  Since the change is trivial enough (one line change),
even if there is a merge conflict (very unlikely, just tried linux-next
and did not see), Linus will be able to handle it.  So I'd rather not
split.  What'd you say, Kumar?

> >  arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig |    1 +
> >  arch/powerpc/configs/mpc85xx_defconfig           |    1 +
> >  arch/powerpc/configs/mpc85xx_smp_defconfig       |    1 +

-- 
Regards,
Shawn
