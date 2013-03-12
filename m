From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 12:01:24 -0600
Subject: [PATCH v2] ARM: tegra: expose chip ID and revision
In-Reply-To: <1363089667-15737-1-git-send-email-dahuang@nvidia.com>
References: <1363089667-15737-1-git-send-email-dahuang@nvidia.com>
Message-ID: <513F6D74.8010107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 06:01 AM, Danny Huang wrote:
> Expose Tegra chip ID and revision in /sys/devices/soc for user mode
> usage

> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c

> +void __init tegra_soc_device_init(void)

Oh, and since this is exposing data that's initialized by Tegra's
fuse.c, wouldn't it make sense to put this function into fuse.c at the
end of its initialization function?
