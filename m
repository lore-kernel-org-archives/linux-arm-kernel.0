From: horms@verge.net.au (Simon Horman)
Date: Thu, 6 Aug 2015 09:35:12 +0900
Subject: [PATCH v4 0/6] ARM: shmobile: r8a7740/sh73a0 DT Cache Handling
In-Reply-To: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150806003511.GB17231@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Wed, Aug 05, 2015 at 10:58:04AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series add L1 and L2 cache descriptions to DT for r8a7740 and
> sh73a0, and migrates the shmobile DT-based generic r8a7740 and
> armadillo legacy platforms from calling l2x0_of_init() to the generic
> l2c OF initialization.
> 
> Note that the conversion to the generic l2c OF initialization is not
> done yet for sh73a0, as this initializes the L2 cache earlier, breaking
> the (fragile) sh73a0 secondary CPU bringup code.
> 
> Also note that this conversion should be done on r8a7778, and r8a7779,
> too.
> 
> Changes compared to v3 ("[PATCH v3 0/6] ARM: l2c / shmobile: r8a7740 : Shared
> Override",
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/340636.html):
>   - "l2c: Add support for the "arm,shared-override" property" was split
>     off into an independent patch, and is now queued for v4.3 in
>     arm/for-next,
>   - Dropped armadillo legacy migration, as it no longer exists,
>   - Added sh73a0 L1 and L2 DT cache description.
> 
> Changes compared to v2 ("[PATCH v2 0/5] ARM: shmobile: r8a7740/armadillo:
> Migrate to generic l2c OF",
> http://www.spinics.net/lists/devicetree/msg68176.html):
>   - Add DT support for Shared Override,
>   - Setting Shared Override is done only if CMA is not available (as
>     Russell claims it's not needed if CMA is available),
>   - Use 0/~0 in machine_desc.l2c_aux_{val,mask}, as DT now supports
>     "arm,shared-override".
> 
> Changes compared to v1:
>   - Fix interrupt reference in DT,
>   - Describe L2 better in DT,
>   - Keep only {,~}L2C_AUX_CTRL_SHARED_OVERRIDE in
>     machine_desc.l2c_aux_{val,mask}, as there's no DT property for
>     this.
>   - Add L1 cache to DT.
> 
> Dependencies:
>   - This series applies to renesas-devel-20150805-v4.2-rc5,
>   - Patch 2 depends on patch 1,
>   - Patch 4 depends on patch 2,
>   - Patch 5 depends on patch 1 and on "ARM: 8395/1: l2c: Add support for
>     the "arm,shared-override" property" in arm/for-next,
>   - Patch 6 depends on patch 5.
> 
> Given C code patches depending on DT patches in the same branch are
> frowned upon, I think it would be best if patch 1 (and patch 3, if
> anyone thinks we may fix the secondary CPU bringup issue during the next
> 3 months) are queued for v4.3. The other patches can be queued for
> 2016^H^H^H^Hv4.4.

Sorry for surprising you with that merge-order requirement.

Unfortunately I am not comfortable with taking patch 1 for v4.3 because:
1. Its now very late in the cycle
2. There now seems to be some discussion around it.

I think I am happy to take the other patches for v4.4, now. But perhaps
I should wait for the discussion around patch 1 to conclude first?
