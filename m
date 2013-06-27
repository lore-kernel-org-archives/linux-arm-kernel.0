From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 27 Jun 2013 18:10:44 +0800
Subject: [PATCH 05/11] ARM: tegra114: shut off the CPU rail when the
 last CPU in suspend
In-Reply-To: <51CB42A0.4070103@wwwdotorg.org>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
 <1372152475-18617-6-git-send-email-josephl@nvidia.com>
 <51CB42A0.4070103@wwwdotorg.org>
Message-ID: <1372327844.9389.31.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-06-27 at 03:36 +0800, Stephen Warren wrote:
> On 06/25/2013 03:27 AM, Joseph Lo wrote:
> > When the last CPU core in suspend, the CPU power rail can be turned off
> > by setting flags to flow controller. Then the flow controller will inform
> > PMC to turn off the CPU rail when the last CPU goes into suspend.
> 
> > diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
> 
> > +	/* Turn off CRAIL */
> > +	if (tegra_chip_id == TEGRA114) {
> 
> 
> Presumably this new code is needed on Tegra114 and chips after it, so
> not needing it is the exception? If so, I'd suggest the following
> instead, so the code doesn't have to be modified for later chips:
> 
> switch (tegra_chip_id) {
> case TEGRA20:
> case TEGRA30:
> 	break;
> default:
> 	the code you added
> 	break;
> }
> 

Indeed. Good idea. Will fix.

Thanks.
