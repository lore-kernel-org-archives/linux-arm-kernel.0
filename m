From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 14 Sep 2014 05:01:41 -0400
Subject: [PATCH 0/2] irqchip: gicv3: add initial CPU PM support
In-Reply-To: <1409065415-20176-1-git-send-email-sudeep.holla@arm.com>
References: <1409065415-20176-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20140914090141.GZ21986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 04:03:33PM +0100, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> This patch series adds initial support for CPU power management with GICv3.
> 
> When a CPU enters a low power state, the GICv3 system registers are lost.
> They need to be saved and restored if required. Currently as the GICv3
> system configuration register are not modified at runtime, the patch
> just re-initialise to initial values.
> 
> This series only supports CPU power states. However, for system power
> states, we may need to save and restore states of distributor and
> re-distributors additionally.
> 
> Currently this is tested only on models, testing on real hardware is
> much appreciated.
> 
> Regards,
> Sudeep
> 
> Sudeep Holla (2):
>   GICv3: refactor gic_enable_redist to support both enabling and
>     disabling
>   GICv3: implement CPU PM notifier
> 
>  drivers/irqchip/irq-gic-v3.c | 87 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 21 deletions(-)

Series applied to irqchip/gic with Marc's Ack.

thx,

Jason.
