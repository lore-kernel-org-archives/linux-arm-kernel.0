From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 16:57:36 +0200
Subject: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <20140711091207.GY23218@tbergstrom-lnx.Nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
 <20140711091207.GY23218@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140711145735.GB6523@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 12:12:07PM +0300, Peter De Schrijver wrote:
> On Fri, Jul 11, 2014 at 06:35:56AM +0200, Viresh Kumar wrote:
> > Hi Tuomas,
> > 
> > On 11 July 2014 03:12, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> > > Add a new cpufreq driver for Tegra124. Instead of using the PLLX as
> > > the CPU clocksource, switch immediately to the DFLL. It allows the use
> > > of higher clock rates, and will automatically scale the CPU voltage as
> > > well. We also rely on the DFLL driver to determine the CPU clock
> > > frequencies that the chip supports, so that we can directly build a
> > > cpufreq table with the OPP library helper dev_pm_opp_init_cpufreq_table.
> > >
> > > This driver is a completely independent of the old cpufreq driver
> > > (tegra-cpufreq), which is only used on Tegra20.
> > >
> > > Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> > 
> > Please reuse cpufreq-cpu0 instead of adding a new driver. Similar
> > is being adopted by all platforms now: krait, mvebu, etc..
> 
> I don't think that's going to work? The voltage scaling is handled in hw.

Do we have to handle it in hardware or can we opt to do it in software,
too?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/05bc940b/attachment.sig>
