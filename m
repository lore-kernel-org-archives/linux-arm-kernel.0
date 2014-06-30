From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 30 Jun 2014 17:08:53 +0100
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <20140630144217.GV3679@tbergstrom-lnx.Nvidia.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53ADAA1C.70407@ti.com> <20140627232757.GB26184@ulmo>
 <20140630102512.GE28951@arm.com>
 <20140630114621.GT3679@tbergstrom-lnx.Nvidia.com>
 <20140630141334.GK28951@arm.com>
 <20140630144217.GV3679@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140630160853.GQ28951@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 03:42:17PM +0100, Peter De Schrijver wrote:
> > > There might be some value for Tegra114 and Tegra124 if we would like
> > > to use HYP mode, but that's not on the radar today. It's a waste of
> > > time for Tegra20 and Tegra30.
> > 
> > I think you should keep the Hyp support in mind anyway and test Linux
> > booting in NS mode on your platforms. It may not be on your radar today
> > for a SoC but if you later decide that it is, we end up with needing
> > different code paths in Linux for the same SoC depending on how it boots
> > (and you can't easily detect this at boot time, nor you can pass it via
> > DT).
> 
> You can just look for a psci DT node? If this node is missing, fallback to
> the existing tegra specific mechanism. At least, that's how I envision doing
> PSCI for HYP mode on v7 based boards where linux today runs in secure mode.

This should work, assuming that setup required before the DT is
available is already handled by firmware (for example, SMP coherency bit
in secure-only registers).

> u-boot loads a minimal secure monitor which only does PSCI (we don't care about
> any security as there are no keys available for signing on those boards
> anyway), adds the PSCI node to the DT and then boots linux in HYP mode. 

BTW, there are some patches under review for adding PSCI support to
U-Boot.

-- 
Catalin
