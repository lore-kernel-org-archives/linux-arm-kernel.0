From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 04 Apr 2013 12:15:54 -0600
Subject: [PATCH] clk: tegra: Fix cdev1 and cdev2 IDs
In-Reply-To: <1365066304-2327-1-git-send-email-pgaikwad@nvidia.com>
References: <1365066304-2327-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <515DC35A.4030301@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 03:05 AM, Prashant Gaikwad wrote:
> Correct IDs for cdev1 and cdev2 are 94 and 93 respectively.

This looks OK, but needs to be split up before I can apply it.

The binding change and driver changes will be applied to Tegra's
for-3.10/clk branch, since that's where clk changes are going.

The DT changes will be applied to Tegra's for-3.10/dt branch, since
that's where most of the DT content that's being edited here was
actually added, this kernel cycle.

There's no dependency between these two sets of changes, since the
clocks properties for the sound and USB PHY nodes aren't actually used
by the drivers yet; they're just being added this kernel cycle to avoid
dependencies in the next kernel version.

Mike, can you please ack this patch anyway, and I'll repost later in the
day when I get around to splitting it up and applying it. Thanks.
