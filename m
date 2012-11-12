From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 12 Nov 2012 14:39:10 +0200
Subject: [PATCH] ARM: tegra: retain L2 content over CPU suspend/resume
In-Reply-To: <1352194377-6209-1-git-send-email-josephl@nvidia.com>
References: <1352194377-6209-1-git-send-email-josephl@nvidia.com>
Message-ID: <20121112123910.GJ1962@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 10:32:57AM +0100, Joseph Lo wrote:
> The L2 RAM is in different power domain from the CPU cluster. So the
> L2 content can be retained over CPU suspend/resume. To do that, we
> need to disable L2 after the MMU is disabled, and enable L2 before
> the MMU is enabled. But the L2 controller is in the same power domain
> with the CPU cluster. We need to restore it's settings and re-enable
> it after the power be resumed.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  arch/arm/mach-tegra/common.c  |    6 +++++-
>  arch/arm/mach-tegra/headsmp.S |   11 +++++++++++
>  arch/arm/mach-tegra/pm.c      |    2 --
>  arch/arm/mach-tegra/pm.h      |    2 ++
>  arch/arm/mach-tegra/sleep.S   |    7 +++++++
>  arch/arm/mach-tegra/sleep.h   |   28 ++++++++++++++++++++++++++++
>  6 files changed, 53 insertions(+), 3 deletions(-)

Apart from the missing define:

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>                                                                                                         
