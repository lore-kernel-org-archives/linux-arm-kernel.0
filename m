From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Sep 2016 23:00:32 +0100
Subject: [PATCH v1] ARM: decompressor: reset ttbcr fields to use TTBR0 on
 ARMv7
In-Reply-To: <1475066728-27290-1-git-send-email-sramana@codeaurora.org>
References: <3441d0c3-c4b6-a795-a841-b61a8866ce17@arm.com>
 <1475066728-27290-1-git-send-email-sramana@codeaurora.org>
Message-ID: <20160928220032.GN1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 06:15:28PM +0530, Srinivas Ramana wrote:
> If the bootloader uses the long descriptor format and jumps to
> kernel decompressor code, TTBCR may not be in a right state.
> Before enabling the MMU, it is required to clear the TTBCR.PD0
> field to use TTBR0 for translation table walks.
> 
> The commit dbece45894d3a ("ARM: 7501/1: decompressor:
> reset ttbcr for VMSA ARMv7 cores") does the reset of TTBCR.N, but
> doesn't consider all the bits for the size of TTBCR.N.
> 
> Clear TTBCR.PD0 field and reset all the three bits of TTBCR.N to
> indicate the use of TTBR0 and the correct base address width.
> 
> Fixes: dbece45894d3 ("ARM: 7501/1: decompressor: reset ttbcr for VMSA ARMv7 cores")
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>

Please submit to the patch system, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
