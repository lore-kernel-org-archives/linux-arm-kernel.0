From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 5 Dec 2014 10:40:09 +0000
Subject: [PATCH v4 0/5] Add Spreadtrum Sharkl64 Platform support
In-Reply-To: <1417692860-18841-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sc9836v4>
 <1417692860-18841-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20141205104009.GE11889@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 04, 2014 at 11:34:15AM +0000, Chunyan Zhang wrote:
> Spreadtrum is a rapid growing chip vendor providing smart phone total solutions.
> 
> Sharkl64 Platform is nominated as a SoC infrastructure that supports 4G/3G/2G
> standards based on ARMv8 multiple core architecture.Now we have only one
> SoC(SC9836) based on this Platform in developing.
> 
> This patchset adds Sharkl64 support in arm64 device tree and the serial driver
> of SC9836-UART.
> 
> This patchset also has patches which address "sprd" prefix and DT compatible
> strings for nodes which appear un-documented.
> 
> This version code was tesed both on Fast Mode and sc9836-fpga board.
> We use the latest boot-wrapper-aarch64 as the bootloader.
> 
> Changes from v3:
> * Addressed review comments:
> 	- Added the description of clock property for sc9836-uart
> 	- Revised the size of GICC to be 8KiB
> 	- Added another compatible string for psci-0.1

I had open questions on v3 regarding your PSCI imlpementation. You
mentioned that you are using the aarch64 bootwrapper, but your DT
describes PSCI 0.2, and the (upstream) bootwrapper does not implement
PSCI 0.2. Adding the old PSCI compatible string is _not_ sufficient if
you do not have a full PSCI 0.2 implementation.

Given that PSCI 0.2 requires more functionality to be implemented, I'd
like to know that your implementation is spec-compliant (implementing
the mandatory functions, nters the kernel in the correct state, etc),
and that it has been tested.

Would you be able to look at my comments from the last posting please?

Thanks,
Mark.
