From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 6 Oct 2012 13:46:14 +0200
Subject: [PATCH] ARM: OMAP: convert I2C driver to PM QoS for MPU latency
 constraints
In-Reply-To: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
References: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
Message-ID: <20121006114614.GB10164@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 06:08:03PM +0200, Jean Pihet wrote:
> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
> API to the new PM QoS API.
> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
> class of PM QoS. The resulting MPU constraints are used by cpuidle to
> decide the next power state of the MPU subsystem.
> 
> The I2C device latency timing is derived from the FIFO size and the
> clock speed and so is applicable to all OMAP SoCs.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Applied to -next, thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121006/51890e5c/attachment.sig>
