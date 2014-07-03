From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 3 Jul 2014 16:51:31 +0300
Subject: [PATCH 6/6] thermal: Add Tegra SOCTHERM thermal management driver
In-Reply-To: <53B2FD61.9000101@wwwdotorg.org>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-7-git-send-email-mperttunen@nvidia.com>
 <53B1D538.6000704@wwwdotorg.org> <53B26BF2.7090009@nvidia.com>
 <53B2FD61.9000101@wwwdotorg.org>
Message-ID: <53B55FE3.6010202@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/07/14 21:26, Stephen Warren wrote:
>
> Ah, so there's some manufacturing calibration process that sets some
> fuse value, and the HW uses a combination of that fuse value, and some
> parameters of the manufacturing process as represented by the
> SENSOR_CONFIG2 register, to apply the calibration? I wonder why
> SENSOR_CONFIG2 is a register not a fuse in that case, but anyway...
>
> Perhaps some comments or kerneldoc in the definition of struct
> tegra_tsensor would be useful?

Yes, I'll add some comments.

>
> Why not read THERMCTL_INTR_STATUS inside the IRQ thread. IIRC, if the
> ISR wakes an IRQ thread, the interrupt remains disable until the thread
> has run its course, so there's no issue deferring the register read
> until the thread runs, at which point, the thread can simply loop over
> all the sensors.
>

If that's the case, then that's definitely a better way to do it.
