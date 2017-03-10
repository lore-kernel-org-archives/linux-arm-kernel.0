From: sumit.semwal@linaro.org (Sumit Semwal)
Date: Fri, 10 Mar 2017 14:23:53 +0530
Subject: [RFC PATCH 08/12] cma: Store a name in the cma structure
In-Reply-To: <1488491084-17252-9-git-send-email-labbott@redhat.com>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <1488491084-17252-9-git-send-email-labbott@redhat.com>
Message-ID: <CAO_48GEHxuMMwZO71ytaVhRkapMYaAWBWd1gW+ktspnQg=b8Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

Thanks for the patch.

On 3 March 2017 at 03:14, Laura Abbott <labbott@redhat.com> wrote:
>
> Frameworks that may want to enumerate CMA heaps (e.g. Ion) will find it
> useful to have an explicit name attached to each region. Store the name
> in each CMA structure.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  drivers/base/dma-contiguous.c |  5 +++--
>  include/linux/cma.h           |  4 +++-
>  mm/cma.c                      | 11 +++++++++--
>  mm/cma.h                      |  1 +
>  mm/cma_debug.c                |  2 +-
>  5 files changed, 17 insertions(+), 6 deletions(-)
>
<snip>
> +const char *cma_get_name(const struct cma *cma)
> +{
> +       return cma->name ? cma->name : "(undefined)";
> +}
> +
Would it make sense to perhaps have the idx stored as the name,
instead of 'undefined'? That would make sure that the various cma
names are still unique.

>  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
>                                              int align_order)
>  {
> @@ -168,6 +173,7 @@ core_initcall(cma_init_reserved_areas);
>   */
>  int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>                                  unsigned int order_per_bit,
> +                                const char *name,
>                                  struct cma **res_cma)
>  {

Best regards,
Sumit.
