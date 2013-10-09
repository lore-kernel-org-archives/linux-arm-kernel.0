From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Oct 2013 17:25:29 -0600
Subject: [PATCH 5/7] ARM: tegra: hook the LP1 iram code area and sleep_core
 function for Tegra124
In-Reply-To: <1381310411-11391-6-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
 <1381310411-11391-6-git-send-email-josephl@nvidia.com>
Message-ID: <5255E5E9.50503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 03:20 AM, Joseph Lo wrote:
> To support LP1, we need to hook sleep_core function. That will turn off
> MMU and jump to the IRAM to execute the rest of LP1 suspend function.
> And we need the the LP1 IRAM addr to backup the original content and
> replace it with LP1 low level support code.

Actually, I'd be tempted to squash all of patches 2-5 together.
