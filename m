From: maxin.john@gmail.com (Maxin B John)
Date: Wed, 10 Aug 2011 14:12:11 +0300
Subject: [PATCH] arch:arm:plat-omap:iovmm: remove unused variable 'va'
In-Reply-To: <20110808101546.GA25572@maxin>
References: <20110808101546.GA25572@maxin>
Message-ID: <CAMhs6YwHbFknDpOg9e_5XcB-X9qo+DXX3tAaQy5xQopepeKOxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping.

On Mon, Aug 8, 2011 at 1:15 PM, Maxin B. John <maxin.john@gmail.com> wrote:
> The pointer "va" returned from "phys_to_virt(pa)" is never used in
> "sgtable_fill_kmalloc()".So,it is safe to remove this set-but-unused variable.
>
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> ---
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index c60737c..79e7fed 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -423,9 +423,6 @@ static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, u32 da,
> ?{
> ? ? ? ?unsigned int i;
> ? ? ? ?struct scatterlist *sg;
> - ? ? ? void *va;
> -
> - ? ? ? va = phys_to_virt(pa);
>
> ? ? ? ?for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> ? ? ? ? ? ? ? ?unsigned bytes;
>
