From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Jul 2014 08:54:13 +0200
Subject: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <CAKohpomQthJ_XE-HhzW07Q4aVtxQVy97iaL0Vy6Q4Lhw22A=VA@mail.gmail.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpomQthJ_XE-HhzW07Q4aVtxQVy97iaL0Vy6Q4Lhw22A=VA@mail.gmail.com>
Message-ID: <20140723065412.GA15759@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 10:14:44AM +0530, Viresh Kumar wrote:
> On 21 July 2014 21:09, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> 
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 7364a53..df3c73e 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -244,6 +244,7 @@ config ARM_SPEAR_CPUFREQ
> >  config ARM_TEGRA_CPUFREQ
> >         bool "TEGRA CPUFreq support"
> >         depends on ARCH_TEGRA
> > +       depends on GENERIC_CPUFREQ_CPU0
> 
> Wouldn't this also disturb the existing cpufreq driver for earlier
> tegra platforms? i.e. we don't need cpufreq-cpu0 for them
> atleast as of now.

Perhaps this should be "select" rather than "depends on"?

> > +static int tegra124_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +       int ret;
> > +
> > +       cpu_dev = get_cpu_device(0);
> > +       if (!cpu_dev)
> > +               return -ENODEV;
> > +
> 
> Shouldn't we do a of_node_get() here?

I think this would need to be get_device() since it's the struct device
that's being used subsequently.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140723/fd38e09f/attachment.sig>
