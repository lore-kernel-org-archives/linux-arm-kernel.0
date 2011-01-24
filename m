From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 24 Jan 2011 12:09:13 +0530
Subject: [PATCH v2 03/28] ARM: gic: Export irq chip functions
In-Reply-To: <1295834493-5019-4-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-4-git-send-email-ccross@android.com>
Message-ID: <f0f885ab9398a623d0761e728a5ee4df@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin,
> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Colin Cross
> Sent: Monday, January 24, 2011 7:31 AM
> To: linux-tegra at vger.kernel.org
> Cc: Russell King; Linus Walleij; konkers at android.com; Gary King;
> Catalin Marinas; Abhijeet Dharmapurikar; linux-
> kernel at vger.kernel.org; Colin Cross; olof at lixom.net; linux-arm-
> kernel at lists.infradead.org
> Subject: [PATCH v2 03/28] ARM: gic: Export irq chip functions
>
> Some systems combine the GIC with an external interrupt controller.
> On these systems it may be necessary to update both the GIC
> registers
> and the external controller's registers to control IRQ behavior.
> Export the irq chip functions so that these systems can define a
> custom irq chip that calls into the GIC handlers.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
> v2: Updated on top of irq_data changes
>
>  arch/arm/common/gic.c               |   11 +++++------
>  arch/arm/include/asm/hardware/gic.h |   10 ++++++++++
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
Instead of exporting the GIC library, I think we could add the
flexibility with slightly different approach.
Have few common arm patches mainly for PM.
Will post them shortly. Have a look at them.


Regards,
Santosh
