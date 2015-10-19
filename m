From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Oct 2015 17:34:40 +0100
Subject: [UPDATED] [PATCHv4 00/12] arm64: 16K translation granule support
In-Reply-To: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
References: <1445260779-22242-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151019163440.GE29001@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 02:19:26PM +0100, Suzuki K. Poulose wrote:
> This series enables the 16K page size support on Linux for arm64.
> Adds support for 48bit VA(4 level), 47bit VA(3 level) and
> 36bit VA(2 level) with 16K. 16K was a late addition to the architecture
> and is not implemented by all CPUs. Added a check to ensure the
> selected granule size is supported by the CPU, failing which the CPU
> won't proceed with booting. Also the kernel page size is added to the
> kernel image header (patch from Ard).
> 
> KVM support has been dropped from this series, as we need to rewrite the
> KVM stage-2 pagetable handling code to get rid of the fake page table
> levels (as recommended by Christoffer and Marc). So, with 16K, we cannot
> run KVM.
> 
> Patches 1-8	cleans up the kernel page size handling code.
> Patch 9		Adds a check to ensure the CPU supports the selected granule size.
> Patch 10		Adds the page size information to image header.
> Patches 11-12	Adds the support for 16K page size

FWIW, for the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
