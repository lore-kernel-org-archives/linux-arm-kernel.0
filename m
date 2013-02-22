From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 22 Feb 2013 14:43:51 +0200
Subject: [PATCH 0/4] ARM: tegra114: bring up secondary CPU for SMP
In-Reply-To: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
References: <1361515491-16199-1-git-send-email-josephl@nvidia.com>
Message-ID: <20130222124351.GU23234@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 07:44:47AM +0100, Joseph Lo wrote:
> This series bring up secondary CPU for Tegra114. Because we are going to
> support generic power domain later, the conventional powergate driver will
> be removed. So we add the CPU power on/off function in PMC driver first.
> 
> This series was dependent on the patches below.
> "ARM: tegra: Fix unchecked return value"
> "ARM: tegra30: fix the logical detection of power on sequence of warm boot CPUs"
> "ARM: tegra: refactor tegra{20,30}_boot_secondary"
> 

It also depends on 'ARM: tegra: don't unlock MMIO access to DBGLAR for working'
secondary core boot on Tegra114. Otherwise the secondary cores will hang at
bootup.

Cheers,

Peter.
