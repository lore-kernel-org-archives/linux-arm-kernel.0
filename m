From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 23 Oct 2012 08:42:57 +0800
Subject: [PATCH V2 0/7] ARM: tegra30: cpuidle: add LP2 support
In-Reply-To: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
References: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
Message-ID: <1350952977.23509.5.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-19 at 16:48 +0800, Joseph Lo wrote:
> The CPU idle LP2 is a power gating idle mode for Tegra30. It supports the
> secondary CPUs (i.e., CPU1-CPU3) to go into LP2 dynamically. When any of
> the secondary CPUs go into LP2, it can be power gated alone. There is a
> limitation on CPU0. The CPU0 can go into LP2 only when all secondary CPUs
> are already in LP2. After CPU0 is in LP2, the CPU rail can be turned off.
> 
> Verified on Seaboard(Tegra20) and Cardhu(Tegra30).
> 
> This patch set should depend on these two patches:
> d8be3dc ARM: tegra: rename the file of "sleep-tXX" to "sleep-tegraXX"
> 01b176e ARM: tegra30: clocks: add AHB and APB clocks
> 
> Previous work can be found at:
> V1:
> http://www.mail-archive.com/linux-tegra at vger.kernel.org/msg06319.html
> 

Hi Stephen,

I need to abandon this patch set. There is a potential issue that will
cause CPU0 corruption. I am investigate on this and will get back to you
later.

Thanks,
Joseph
