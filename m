From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 25 Feb 2013 10:39:20 +0200
Subject: [PATCH 2/4] ARM: tegra: pmc: add power on function for
 secondary CPUs
In-Reply-To: <5127BAD2.8030904@wwwdotorg.org>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <1361515491-16199-3-git-send-email-josephl@nvidia.com>
 <5127BAD2.8030904@wwwdotorg.org>
Message-ID: <20130225083920.GZ23234@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 07:37:06PM +0100, Stephen Warren wrote:
> On 02/21/2013 11:44 PM, Joseph Lo wrote:
> > Adding the power on function for secondary CPUs in PMC driver, this can
> > help us to remove legacy powergate driver and add generic power domain
> > support later.
> 
> > diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
> 
> > +static u8 tegra_cpu_domains[] = {
> > +	0xFF,			/* not available for CPU0 */
> > +	TEGRA_POWERGATE_CPU1,
> > +	TEGRA_POWERGATE_CPU2,
> > +	TEGRA_POWERGATE_CPU3,
> > +};
> 
> Per Peter's comment, you probably need SoC-specific arrays here, to
> support CPU0 having a valid value or not.

That was a mistake, we never use these functions on CPU0. Powergating uses
a different path. So this is ok.

Cheers,

Peter.
