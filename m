From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Apr 2013 14:23:34 +0800
Subject: [PATCH v6 0/8] Reset controller API to reset IP modules on i.MX5
 and i.MX6
In-Reply-To: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130401062332.GB1693@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 05:35:15PM +0100, Philipp Zabel wrote:
> The system reset controller (SRC) on i.MX51, i.MX53, and i.MX6q controls
> reset lines to the GPU, VPU, IPU, and OpenVG IP modules.
> 
> The following patches add a simple API for devices to request being reset
> by separate reset controller hardware and implements the reset signal
> device tree binding proposed by Stephen Warren. Contrary to Tegra hardware,
> the i.MX SRC contains self-deasserting reset registers, so I've included
> both ops to manually assert/deassert a reset line, as well as a "reset"
> operation that is supposed to assert the reset line and wait for it to
> deassert.
> 
> The i.MX SRC is enhanced to provide a reset controller and the IPU driver
> is made to request being reset by calling the device_reset(&pdev->dev)
> convenience wrapper during probing.
> 
> No changes since v5, I just reordered the series.

All applied, thanks.
