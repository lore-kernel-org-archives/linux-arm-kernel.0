From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Jul 2014 11:10:04 +0200
Subject: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <CAKohponsS8WJy4qBa=3em9AcxfpfLZR_mx4Ln8N3Q_gBaf52NA@mail.gmail.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpomQthJ_XE-HhzW07Q4aVtxQVy97iaL0Vy6Q4Lhw22A=VA@mail.gmail.com>
 <53CFA33F.6030307@nvidia.com>
 <CAKohponLh66Ubr6=wY2OZCCrK11KZDj=DmXXqXsGGTHSG45wpA@mail.gmail.com>
 <53D00A47.7050203@nvidia.com>
 <CAKohponsS8WJy4qBa=3em9AcxfpfLZR_mx4Ln8N3Q_gBaf52NA@mail.gmail.com>
Message-ID: <20140724091002.GA3811@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 05:43:40AM +0530, Viresh Kumar wrote:
> On 24 July 2014 00:47, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> > It's this:
> >
> > +static int tegra124_cpufreq_probe(struct platform_device *pdev)
> > +{
> > [...]
> > +
> > +       dfll_clk = of_clk_get_by_name(cpu_dev->of_node, "dfll");
> > +       if (IS_ERR(dfll_clk)) {
> > +               ret = PTR_ERR(dfll_clk);
> > +               goto out_put_cpu_clk;
> > +       }
> 
> This would search for clocks passed via DT, right? Why would we
> get EPROBE_DEFER for that? Sorry for the stupid question.

of_clk_get_by_name() can return -EPROBE_DEFER, which will happen if the
clock provider hasn't been registered yet.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/4ff0a233/attachment.sig>
