From: james.morse@arm.com (James Morse)
Date: Thu, 28 Jun 2018 18:29:17 +0100
Subject: [PATCH v2 2/4] efi/arm: map UEFI memory map even w/o runtime
 services enabled
In-Reply-To: <20180619064424.6642-3-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-3-takahiro.akashi@linaro.org>
Message-ID: <d910258e-b332-36f3-4024-ed9ab48af278@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 19/06/18 07:44, AKASHI Takahiro wrote:
> Under the current implementation, UEFI memory map will be mapped and made
> available in virtual mappings only if runtime services are enabled.

> But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
> to create mappings of ACPI tables using memory attributes described in
> UEFI memory map.
> 
> So, as a first step, arm_enter_runtime_services() will be modified
> so that UEFI memory map will be always accessible.
> 
> See a relevant commit:
>     arm64: acpi: fix alignment fault in accessing ACPI tables

For what its worth:
Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
