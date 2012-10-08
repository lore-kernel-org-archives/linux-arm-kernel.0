From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 8 Oct 2012 11:00:46 +0200
Subject: [PATCH] ARM: OMAP: convert I2C driver to PM QoS for MPU latency
 constraints
In-Reply-To: <20121006114614.GB10164@pengutronix.de>
References: <1348157283-24119-1-git-send-email-j-pihet@ti.com>
 <20121006114614.GB10164@pengutronix.de>
Message-ID: <CAORVsuWv1HmaiYxfJVr1h5_r_+UHxXLVeLoVmH4RuO5egZoqqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 6, 2012 at 1:46 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Thu, Sep 20, 2012 at 06:08:03PM +0200, Jean Pihet wrote:
>> Convert the driver from the outdated omap_pm_set_max_mpu_wakeup_lat
>> API to the new PM QoS API.
>> Since the constraint is on the MPU subsystem, use the PM_QOS_CPU_DMA_LATENCY
>> class of PM QoS. The resulting MPU constraints are used by cpuidle to
>> decide the next power state of the MPU subsystem.
>>
>> The I2C device latency timing is derived from the FIFO size and the
>> clock speed and so is applicable to all OMAP SoCs.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Applied to -next, thanks!
Thanks!

Jean
>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
