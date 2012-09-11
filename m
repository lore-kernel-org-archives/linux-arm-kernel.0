From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 14:03:01 -0600
Subject: [PATCH] ARM: tegra: config: enable RTC for Cardhu and Whistler
In-Reply-To: <1347387310-13087-1-git-send-email-swarren@wwwdotorg.org>
References: <1347387310-13087-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <504F98F5.2010402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 12:15 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Enable CONFIG_RTC_DRV_TPS65910, CONFIG_RTC_DRV_MAX8907, and some RTC
> options that Kconfig help implies should typically be enabled;
> RTC_INTF_SYSFS, INTF_PROC, RTC_INTF_DEV.
> 
> While rebuilding defconfig:
> 
> * Removed entry for HOTPLUG_CPU since it is now implied by PM_SLEEP_SMP.
> * Enabled MEDIA_USB_SUPPORT, which is a requirement to keep
>   USB_VIDEO_CLASS=m.

Applied to Tegra's for-3.7/defconfig branch. I also squashed all the (3)
patches in that branch into a single patch to avoid a little bit of
churn due to earlier patches enabling some features that ended up being
selected later on, and hence not showing up any more.
