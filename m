From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 27 Jan 2016 09:43:19 -0600
Subject: [PATCHv3 00/18] arm64: mm: rework page table creation
In-Reply-To: <1453722312-23076-1-git-send-email-mark.rutland@arm.com>
References: <1453722312-23076-1-git-send-email-mark.rutland@arm.com>
Message-ID: <56A8E597.8000501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2016 05:44 AM, Mark Rutland wrote:
> Hi all,
>
> This series reworks the arm64 early page table code. This avoids issues with
> conflicting TLB entries, ensures we can always create page tables provided
> there is available memory in the system (even if not covered by the early
> linear map), and allows for fine-grained table creation early on.


I've tested this in a couple machines using ACPI based kernels, 
including the xgene which initially had problems. I've tested it with 
and without CONFIG_DEBUG_RODATA. Everything seems fine.

Thanks,

Tested-by: Jeremy Linton <jeremy.linton@arm.com>
