From: dannenberg@ti.com (Andreas Dannenberg)
Date: Wed, 11 May 2016 08:09:13 -0500
Subject: [PATCH 2/2] ARM: dts: dra7: Add ti,secure-ram node to ocmcram1
 node
In-Reply-To: <1462909782-14639-3-git-send-email-d-gerlach@ti.com>
References: <1462909782-14639-1-git-send-email-d-gerlach@ti.com>
 <1462909782-14639-3-git-send-email-d-gerlach@ti.com>
Message-ID: <20160511130913.GS20461@borg.dal.design.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 02:49:42PM -0500, Dave Gerlach wrote:
> Secure variants of DRA7xx and AM57xx SoCs may need to reserve a region
> of the SRAM for use by secure software. To account for this, add a child
> node to the ocmcram1 node that will act as a placeholder at the start
> of the SRAM for the reserved region of memory that may be required
> by secure services. The node is added with size 0 so that by default
> parts will have the full space available but the bootloader or board dts
> file is able to resize the node as needed depending on how much reserved
> space is needed, if any, so end users of the ocmcram1 region on HS parts
> must be aware that a smaller amount of SRAM than expected may be available.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Reviewed-by: Andreas Dannenberg <dannenberg@ti.com>

--
Andreas Dannenberg
Texas Instruments Inc
