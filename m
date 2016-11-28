From: vbabka@suse.cz (Vlastimil Babka)
Date: Mon, 28 Nov 2016 14:29:03 +0100
Subject: [PATCH v2 1/6] mm: hugetlb: rename some allocation functions
In-Reply-To: <1479107259-2011-2-git-send-email-shijie.huang@arm.com>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
 <1479107259-2011-2-git-send-email-shijie.huang@arm.com>
Message-ID: <52b661c9-f4b0-3d94-cf9b-a0ffd5ecb723@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2016 08:07 AM, Huang Shijie wrote:
> After a future patch, the __alloc_buddy_huge_page() will not necessarily
> use the buddy allocator.
>
> So this patch removes the "buddy" from these functions:
> 	__alloc_buddy_huge_page -> __alloc_huge_page
> 	__alloc_buddy_huge_page_no_mpol -> __alloc_huge_page_no_mpol
> 	__alloc_buddy_huge_page_with_mpol -> __alloc_huge_page_with_mpol
>
> This patch makes preparation for the later patch.
>
> Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> ---
>  mm/hugetlb.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3edb759..496b703 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1157,6 +1157,10 @@ static int alloc_fresh_gigantic_page(struct hstate *h,
>
>  static inline bool gigantic_page_supported(void) { return true; }
>  #else
> +static inline struct page *alloc_gigantic_page(int nid, unsigned int order)
> +{
> +	return NULL;
> +}

This hunk is not explained by the description. Could belong to a later 
patch?
