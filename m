From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 8 Nov 2011 20:25:35 +0530
Subject: [PATCH] genirq: don't allow per cpu interrupts to be suspended
In-Reply-To: <1320763712-764-1-git-send-email-marc.zyngier@arm.com>
References: <1320763712-764-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAMQu2gwL+enHoyiAB7LWix3WqW76HMbmSs_DmPX0h8uX=OBmdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 8, 2011 at 8:18 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> The power management functions related to interrupts do not know
> (yet) about per-cpu interrupts and end up calling the wrong
> low-level methods to enable/disable interrupts.
>
> This leads to all kind of interesting issues (action taken on one
> CPU only, updating a refcount which is not used otherwise...).
>
> The workaround for the time being is simply to flag these interrupts
> with IRQF_NO_SUSPEND. At least on ARM, these interrupts are actually
> dealt with at the architecture level.
>
> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
Just to add, the suspend is broken on mainline
for ARM machines which are using IRQCHIP_MASK_ON_SUSPEND.
The $subject patch fixes that issue.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards,
Santosh
