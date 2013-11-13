From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 13 Nov 2013 10:29:41 -0500
Subject: [PATCH V3 6/7] ARM: OMAP4+: Correct Wakeup-gen code to use
 physical irq number
In-Reply-To: <1383657257-3458-7-git-send-email-r.sricharan@ti.com>
References: <1383657257-3458-1-git-send-email-r.sricharan@ti.com>
 <1383657257-3458-7-git-send-email-r.sricharan@ti.com>
Message-ID: <52839AE5.9040906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 November 2013 08:14 AM, Sricharan R wrote:
> The wakeup gen mask/unmask callback uses the irq element of the
> irq_data to setup. The irq is the linux virtual irq number and
> is same as the hardware irq number only when the parent irqchip
> is setup as a legacy domain. When it is used as a linear domain,
> the virtual irqs are allocated dynamically and wakeup gen code
> cannot rely on these numbers to access the irq registers. Instead
> use the hwirq element of the irq_data which represent the physical
> irq number.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
