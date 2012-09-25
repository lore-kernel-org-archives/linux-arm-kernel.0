From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 24 Sep 2012 17:48:07 -0700
Subject: [PATCH] ARM: OMAP: convert I2C driver to PM QoS for MPU latency
 constraints
In-Reply-To: <1348157283-24119-1-git-send-email-j-pihet@ti.com> (Jean Pihet's
 message of "Thu, 20 Sep 2012 18:08:03 +0200")
References: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
Message-ID: <878vbzj5bs.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

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

Acked-by: Kevin Hilman <khilman@ti.com>
