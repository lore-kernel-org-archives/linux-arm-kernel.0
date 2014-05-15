From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 May 2014 10:01:57 +0200
Subject: [PATCH v2 3/5] dt/bindings: ti,
 edma: Remove redundant properties from documentation
In-Reply-To: <1399977032-26469-4-git-send-email-peter.ujfalusi@ti.com>
References: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com>
 <1399977032-26469-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <7468082.VY82PIo3ZY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 May 2014 13:30:30 Peter Ujfalusi wrote:
> From CCCFG register of eDMA3 we can get all the needed information for the
> driver about the IP:
> Number of channels: NUM_DMACH
> Number of regions: NUM_REGN
> Number of slots (PaRAM sets): NUM_PAENTRY
> Number of TC/EQ: NUM_EVQUE
> 
> The ti,edma-regions; ti,edma-slots and dma-channels in DT are
> redundant since the very same information can be obtained from the HW.
> The mentioned properties can be removed from the binding document.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I wonder if we should keep them listed as "optional" properties so you
can have a dtb file that still works with older kernels which need them.

What you do is an incompatible change to the binding, which we shouldn't
do lightly. Any new dts files don't need this information of course, but
as a general rule, I'd rather keep things like this around unless we
already have to enforce an ABI break that is well documented.

	Arnd
