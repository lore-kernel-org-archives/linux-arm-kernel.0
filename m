From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 4 Dec 2012 12:28:47 +0800
Subject: [PATCH 2/5] ARM: tegra20: clocks: add CPU low-power function
 into tegra_cpu_car_ops
In-Reply-To: <50BCED6A.7000702@wwwdotorg.org>
References: <1354503607-13707-1-git-send-email-josephl@nvidia.com>
 <1354503607-13707-3-git-send-email-josephl@nvidia.com>
 <50BCED6A.7000702@wwwdotorg.org>
Message-ID: <1354595327.30563.0.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-12-04 at 02:20 +0800, Stephen Warren wrote:
> On 12/02/2012 08:00 PM, Joseph Lo wrote:
> > Add suspend, resume and rail_off_ready API into tegra_cpu_car_ops. These
> > functions were used for CPU powered-down state maintenance.
> 
> > diff --git a/arch/arm/mach-tegra/tegra20_clocks.c b/arch/arm/mach-tegra/tegra20_clocks.c
> 
> > +static bool tegra20_cpu_rail_off_ready(void)
> 
> > +	if ((cpu_rst_status & 0x2) != 0x2)
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> Perhaps simplify that to:
> 
> return cpu_rst_status & 2;
> 
> or perhaps if that generates an int->bool performance warning:
> 
> return !!(cpu_rst_status & 2);

OK. Will do this.

Thanks,
Joseph
