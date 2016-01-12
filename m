From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jan 2016 18:59:36 +0000
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <1446857519-5908-2-git-send-email-lho@apm.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com>
Message-ID: <56954D18.1010306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/15 00:51, Loc Ho wrote:
> The function acpi_gsi_to_irq should returns 0 on success as upper function
> caller expect an 0 for sucesss.

I have to ask: why do you feel the need to change an API that behaves
like the rest of the IRQ allocation functions (at least when it comes to
its return value)?

0 is defined as an invalid interrupt, and I wish it stayed that way.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
