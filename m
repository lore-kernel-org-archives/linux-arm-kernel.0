From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 24 Feb 2012 11:51:57 +0530
Subject: [PATCH 3/5] ARM: OMAP2+: wakeupgen: Fix wrong array size for
 irq_target_cpu
In-Reply-To: <1330035801-14937-4-git-send-email-b-cousson@ti.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
 <1330035801-14937-4-git-send-email-b-cousson@ti.com>
Message-ID: <CAMQu2gwxViG6bSHG+tn5=GLqtPk+zTZd3MFnSEo=wO7oPUuyuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 3:53 AM, Benoit Cousson <b-cousson@ti.com> wrote:
> The wakeupgen was wrongly allocating an array based on the
> NR_IRQS value (410 on OMAP4) whereas it is just capable of handling 128
> entries.
> Moreover with SPARSE_IRQ, the NR_IRQS number might be 16, and thus
> cannot handle the proper number of entries. It will generate an oops as
> soon a driver will request an IRQ > 16.
>
> Allocate the array using the fixed MAX_IRQS value (128).
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> ?arch/arm/mach-omap2/omap-wakeupgen.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
Right.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
