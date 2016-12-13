From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Dec 2016 12:31:44 +0000
Subject: [PATCHv5 09/11] mm/kasan: Switch to using __pa_symbol and lm_alias
In-Reply-To: <1481068257-6367-10-git-send-email-labbott@redhat.com>
References: <1481068257-6367-1-git-send-email-labbott@redhat.com>
 <1481068257-6367-10-git-send-email-labbott@redhat.com>
Message-ID: <20161213123144.GB24607@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 03:50:55PM -0800, Laura Abbott wrote:
> 
> __pa_symbol is the correct API to find the physical address of symbols.
> Switch to it to allow for debugging APIs to work correctly. Other
> functions such as p*d_populate may call __pa internally. Ensure that the
> address passed is in the linear region by calling lm_alias.
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v5: Add missing lm_alias call
> ---
>  mm/kasan/kasan_init.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
> index 3f9a41c..922f459 100644
> --- a/mm/kasan/kasan_init.c
> +++ b/mm/kasan/kasan_init.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/memblock.h>
>  #include <linux/pfn.h>
> +#include <linux/mm.h>

Nit: include ordering.

Regardless, my tags above still stand!

Thanks,
Mark.
