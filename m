From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 3 Jun 2013 10:16:06 +0800
Subject: [PATCH V2 3/6] ARM: tegra: make tegra_resume can work for Tegra114
In-Reply-To: <201306011147.30379.arnd@arndb.de>
References: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
 <201306010041.07230.arnd@arndb.de> <51A9364B.4090002@wwwdotorg.org>
 <201306011147.30379.arnd@arndb.de>
Message-ID: <1370225766.15568.6.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-06-01 at 17:47 +0800, Arnd Bergmann wrote:
> On Saturday 01 June 2013, Stephen Warren wrote:
> > On 05/31/2013 04:41 PM, Arnd Bergmann wrote:
> > > On Monday 20 May 2013, Joseph Lo wrote:
> > >> +       cpu_to_csr_req r1, r0
> > >> +       mov32   r2, TEGRA_FLOW_CTRL_BASE
> > >> +       ldr     r1, [r2, r1]
> > > 
> > > This causes build errors now, since cpu_to_csr_req is not defined anywhere.
> > 
> > What build error are you seeing? I built next-20130531 earlier today
> > without any issue.
> > 
> > I do remember making a similar comment during review of this patch that
> > cpu_to_csr_req wasn't defined anywhere, but IIRC Joseph pointed me to
> > another patch in the series which had added it, or something like that.
> 
> Sorry, I should have mentioned it was using randconfig, all the defconfig
> builds work fine. The code is inside of "#ifndef CONFIG_ARCH_TEGRA_2x_SOC",
> but Tegra2 is normally enabled in defconfig, so it does not get built.
> 
> I suspect the #ifdef is wrong as well, and should have been "if tegra3
> or tegra4" instead. Joseph, can you clarify the intent of this?
> 
> 	Arnd

Arnd,

I think the "ifdef" should be removed here because we had a runtime
Tegra SoC detection code here, the "ifdef" here would cause the code
won't be built for the tegra_defconfig that we are using. And a typo
need to fix here, it should be "cpu_to_csr_reg" not "cpu_to_csr_req".
Sorry.

Thanks for report. Will provide a fix.

Joseph
