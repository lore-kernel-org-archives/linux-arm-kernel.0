From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Jun 2014 11:29:29 -0600
Subject: [PATCH 0/9] Serial ATA support for NVIDIA Tegra124
In-Reply-To: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <5390A8F9.2090408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> Hi,
> 
> This series adds support for the onboard AHCI-compliant Serial ATA
> controller found on Tegra124 systems-on-chip. The controller is
> enabled on Jetson TK1. The series depends on Peter's efuse series 
> and Thierry's yet to be submitted XUSB pinctrl driver.

This series includes patches to a lot of different subsystems. That will
complicate applying it.

Can you write a summary of the *compile time* dependencies, since that
will influence how the patches get merged.

You mentioned that this series depends on efuse and XUSB padctl. Can you
point out which specific parts of this series depend on which of those
two other series, and whether this is a compile-time or run-time dependency.

I hope that the drivers/ata patches, drivers/clk patches, DT, and
defconfig patches can each be applied to their normal tree and don't
depend on each-other at compile-time at all.

At run-time, obviously all the patches are needed to make the code work,
but since this is a new feature, it's fine if this all only works once
everything is merged together in linux-next or Linus's tree.

Thanks.
