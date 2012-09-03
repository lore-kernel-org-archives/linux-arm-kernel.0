From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 3 Sep 2012 10:46:06 +0800
Subject: [PATCH v4 2/7] ARM: imx6q: add iomuxc gpr support into syscon
In-Reply-To: <20120831020247.GC7726@r65073-Latitude-D630>
References: <1346237818-9498-1-git-send-email-b29396@freescale.com>
 <1346237818-9498-3-git-send-email-b29396@freescale.com>
 <20120831020247.GC7726@r65073-Latitude-D630>
Message-ID: <20120903024606.GC11891@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 10:02:48AM +0800, Shawn Guo wrote:
> On Wed, Aug 29, 2012 at 06:56:53PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > Include headfile for easy using.
> > 
> > Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > ---
> >  arch/arm/boot/dts/imx6q.dtsi         |    5 +
> >  include/linux/fsl/imx6q-iomuxc-gpr.h |  319 ++++++++++++++++++++++++++++++++++
> 
> I assume that all the users of this header file are imx6q syscon
> clients.  In that case, this header belongs to mfd/syscon subsystem.
> 
> I have been told by people that it was a mistake to create
> include/linux/fsl.  Each header in include/linux should go to
> respective subsystem sub-directory.  For this particular case,
> it should be include/linux/mfd or include/linux/mfd/syscon even
> better, IMO.
> 
I like the later one if not put in include/linux/fsl. :)

> > +#define IMX6Q_GPR13_SATA_PHY_1_MED		(0x1 << 0)
> > +#define IMX6Q_GPR13_SATA_PHY_1_SLOW		(0x2 << 0)
> > +
> > +#endif /* !__LINUX_IMX6Q_IOMUXC_GPR_H */
> 
> Nit: why do we have a "!" there?
> 
You're right.
We do not need a '!' for such macro.
Sorry for my mistake.

Regards
Dong Aisheng
