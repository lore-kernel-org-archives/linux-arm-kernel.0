From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 29 Mar 2018 15:22:30 +0200
Subject: [PATCH] iommu/io-pgtable-arm: Avoid warning with 32-bit
 phys_addr_t
In-Reply-To: <7181ab429dc33f407ca53d66ec36d1c4d28f74cd.1522322035.git.robin.murphy@arm.com>
References: <7181ab429dc33f407ca53d66ec36d1c4d28f74cd.1522322035.git.robin.murphy@arm.com>
Message-ID: <20180329132230.cotfy65lgaiqrexk@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2018 at 12:24:52PM +0100, Robin Murphy wrote:
> It's not entirely unreasonable for io-pgtable-arm to be built for
> configurations with 32-bit phys_addr_t, where the compiler rightly
> raises a warning about the 36-bit shift. That particular code path
> should never actually *run* on those systems, but we still want it
> to compile cleanly, which is easily done by using an unambiguous u64
> as the intermediate type instead.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Oops, I managed to totally overlook that phys_addr_t would be
> configuration-dependent, sorry :(
> 
> If this can't sneak in on top of the SMMU pull, I'll resend it 
> as a fix for -rc1. It shouldn't be super-critical.
> 
>  drivers/iommu/io-pgtable-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied it, thanks Robin.
