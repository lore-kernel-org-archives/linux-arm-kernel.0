From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Jul 2013 16:51:53 -0600
Subject: [PATCH 3/8] clk: tegra114: add LP1 suspend/resume support
In-Reply-To: <1374830110-30685-4-git-send-email-josephl@nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <1374830110-30685-4-git-send-email-josephl@nvidia.com>
Message-ID: <51F6F209.2090309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2013 03:15 AM, Joseph Lo wrote:
> When the system suspends to LP1, the clock of the CPU would be switched to
> CLK_M (12MHz Oscillator) during suspend/resume flow. The clock driver
> needs to restore the clock of CPU after LP1 resume.

It's unclear to me how the code change implements "restore the clock of
the CPU". A register name of CCLKG_BURST_POLICY doesn't sound like it's
anything to do with enabled/disabling the CPU clock, nor configuring its
rate. What exactly does this register do, and hence what does this new
code actually restore?

Why don't Tegra20/30 need a similar change?
