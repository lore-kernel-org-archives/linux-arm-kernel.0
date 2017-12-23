From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 23 Dec 2017 12:35:45 +0800
Subject: [PATCH 1/1] ARM: imx_v6_v7_defconfig: enable CONFIG_CPU_FREQ_STAT
In-Reply-To: <CAOMZO5CucxOE3VY4tQ2rwhmr6y6sV70XmBtH35StP+Hk+6z-qw@mail.gmail.com>
References: <1513937101-17643-1-git-send-email-aisheng.dong@nxp.com>
 <CAOMZO5CucxOE3VY4tQ2rwhmr6y6sV70XmBtH35StP+Hk+6z-qw@mail.gmail.com>
Message-ID: <20171223043545.GA32736@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, Dec 22, 2017 at 06:59:54PM -0200, Fabio Estevam wrote:
> Hi Dong,
> 
> On Fri, Dec 22, 2017 at 8:05 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:
> 
> > diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> > index 0d44949..e58be5d 100644
> > --- a/arch/arm/configs/imx_v6_v7_defconfig
> > +++ b/arch/arm/configs/imx_v6_v7_defconfig
> > @@ -48,13 +48,12 @@ CONFIG_PCI_IMX6=y
> >  CONFIG_SMP=y
> >  CONFIG_ARM_PSCI=y
> >  CONFIG_PREEMPT_VOLUNTARY=y
> > -CONFIG_AEABI=y
> >  CONFIG_HIGHMEM=y
> > -CONFIG_CMA=y
> >  CONFIG_FORCE_MAX_ZONEORDER=14
> >  CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
> >  CONFIG_KEXEC=y
> >  CONFIG_CPU_FREQ=y
> > +CONFIG_CPU_FREQ_STAT=y
> >  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
> >  CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> >  CONFIG_CPU_FREQ_GOV_USERSPACE=y
> > @@ -81,7 +80,6 @@ CONFIG_CAN_FLEXCAN=y
> >  CONFIG_BT=y
> >  CONFIG_BT_HCIUART=y
> >  CONFIG_BT_HCIUART_H4=y
> > -CONFIG_BT_HCIUART_LL=y
> 
> This option is gone since it now depends on CONFIG_BT_HCIUART_SERDEV=y.
> 
> Please rebase your patch against Shawn's origin/imx/defconfig.
> 
> There is one commit in this branch that adds
> CONFIG_BT_HCIUART_SERDEV=y, which then avoids the automatic removal of
> CONFIG_BT_HCIUART_LL.
> 

Got it.
Thanks for the kind reminder.

Regards
Dong Aisheng
