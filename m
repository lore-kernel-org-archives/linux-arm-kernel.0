From: ilialin@codeaurora.org (ilialin at codeaurora.org)
Date: Tue, 20 Mar 2018 22:34:04 +0200
Subject: [PATCH v3 09/10] DT: QCOM: Add cpufreq-dt to msm8996
In-Reply-To: <152157637794.125118.12382168941652366593@swboyd.mtv.corp.google.com>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-10-git-send-email-ilialin@codeaurora.org>
 <152147812199.242365.11821734771337881765@swboyd.mtv.corp.google.com>
 <013a01d3c051$d65a9160$830fb420$@codeaurora.org>
 <152157637794.125118.12382168941652366593@swboyd.mtv.corp.google.com>
Message-ID: <017c01d3c08a$cf903270$6eb09750$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Understood, what you mean. I assumed that the cpufreq-dt is generic driver, and adding architecture specific code to it is no not correct from architectural point of view. Anyway, I'm considering adding a platform specific cpufreq driver, which will handle the efuse data as well.

Meanwhile this is the way to use the generic driver.

> -----Original Message-----
> From: Stephen Boyd <sboyd@kernel.org>
> Sent: Tuesday, March 20, 2018 22:06
> To: ilialin at codeaurora.org; linux-arm-kernel at lists.infradead.org; linux-arm-
> msm at vger.kernel.org; linux-clk at vger.kernel.org; sboyd at codeaurora.org
> Cc: mark.rutland at arm.com; devicetree at vger.kernel.org;
> rnayak at codeaurora.org; robh at kernel.org; will.deacon at arm.com;
> amit.kucheria at linaro.org; tfinkel at codeaurora.org;
> nicolas.dechesne at linaro.org; celster at codeaurora.org
> Subject: RE: [PATCH v3 09/10] DT: QCOM: Add cpufreq-dt to msm8996
> 
> Quoting ilialin at codeaurora.org (2018-03-20 06:46:19)
> > > From: Stephen Boyd <sboyd@kernel.org> Quoting Ilia Lin (2018-02-14
> > > 05:59:51)
> > > > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> > > > b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > > index 3b585e4..b6cd0ae 100644
> > > > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > > > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > > @@ -95,6 +95,9 @@
> > > >         { .compatible = "xlnx,zynq-7000", },
> > > >         { .compatible = "xlnx,zynqmp", },
> > > >
> > > > +       { .compatible = "qcom,msm8996", },
> > > > +       { .compatible = "qcom,apq8096", },
> > > > +
> > >
> > > Why can't we base it on the kryocc node being present?
> > This could be good idea, if I would writing a platform specific cpufreq driver,
> which may be a future option.
> 
> Well maybe cpufreq-dt can also look at the cpus nodes for a cpu with a
> certain type (in this case kryo). Then we can add cpufreq dt based on that
> CPU node being there.
> 
> > > Or even populate
> > > the cpufreq-dt from the kryocc driver?
> > There is a problem that during the clock probe the OPP table still doesn't
> exist.
> 
> The OPP table is in DT? Why doesn't it exist?
