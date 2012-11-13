From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Nov 2012 12:13:07 -0700
Subject: [PATCH V2] ARM: tegra: retain L2 content over CPU suspend/resume
In-Reply-To: <1352772288-2290-1-git-send-email-josephl@nvidia.com>
References: <1352772288-2290-1-git-send-email-josephl@nvidia.com>
Message-ID: <50A29BC3.1020808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2012 07:04 PM, Joseph Lo wrote:
> The L2 RAM is in different power domain from the CPU cluster. So the
> L2 content can be retained over CPU suspend/resume. To do that, we
> need to disable L2 after the MMU is disabled, and enable L2 before
> the MMU is enabled. But the L2 controller is in the same power domain
> with the CPU cluster. We need to restore it's settings and re-enable
> it after the power be resumed.

Thanks, applied to Tegra's for-3.8/cpuidle branch.
