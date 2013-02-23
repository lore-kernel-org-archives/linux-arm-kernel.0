From: josephl@nvidia.com (Joseph Lo)
Date: Sat, 23 Feb 2013 09:57:21 +0800
Subject: [PATCH 0/4] ARM: tegra114: bring up secondary CPU for SMP
In-Reply-To: <20130222124351.GU23234@tbergstrom-lnx.Nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
 <20130222124351.GU23234@tbergstrom-lnx.Nvidia.com>
Message-ID: <1361584641.1804.5.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-22 at 20:43 +0800, Peter De Schrijver wrote:
> On Fri, Feb 22, 2013 at 07:44:47AM +0100, Joseph Lo wrote:
> > This series bring up secondary CPU for Tegra114. Because we are going to
> > support generic power domain later, the conventional powergate driver will
> > be removed. So we add the CPU power on/off function in PMC driver first.
> > 
> > This series was dependent on the patches below.
> > "ARM: tegra: Fix unchecked return value"
> > "ARM: tegra30: fix the logical detection of power on sequence of warm boot CPUs"
> > "ARM: tegra: refactor tegra{20,30}_boot_secondary"
> > 
> 
> It also depends on 'ARM: tegra: don't unlock MMIO access to DBGLAR for working'
> secondary core boot on Tegra114. Otherwise the secondary cores will hang at
> bootup.
> 
Thanks for reminder. This is definitely needed.

Joseph
