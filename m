From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 11:32:51 +0000
Subject: [PATCH 2/5] arm: mvebu: Select DMA_BOUNCE when LPAE is
 selected in Kconfig
In-Reply-To: <1363883179-1361-3-git-send-email-gregory.clement@free-electrons.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130322113251.GB4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 05:26:15PM +0100, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> For mvebu IOs are 32 bits and we have 40 bits memory due to LPAE so
> make sure we give 32 bits addresses to the IOs.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Tested-by: Franklin <flin@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Oh god no.  Please move away from the addition on DMABOUNCE - that code
creaks, doesn't have highmem support, and is known to give problems on
various platforms.

Instead, please rely on using the DMA mask and such like, just like on
x86.
