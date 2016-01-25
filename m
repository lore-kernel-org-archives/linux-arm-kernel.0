From: labbott@redhat.com (Laura Abbott)
Date: Mon, 25 Jan 2016 10:41:47 -0800
Subject: [PATCH 2/4] arm: let set_memory_xx(addr, 0) succeed.
In-Reply-To: <1453561543-14756-3-git-send-email-mika.penttila@nextfour.com>
References: <1453561543-14756-1-git-send-email-mika.penttila@nextfour.com>
 <1453561543-14756-3-git-send-email-mika.penttila@nextfour.com>
Message-ID: <56A66C6B.7000806@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2016 07:05 AM, mika.penttila at nextfour.com wrote:
> From: Mika Penttil? <mika.penttila@nextfour.com>
>
> This makes set_memory_xx() consistent with x86.
>
> Signed-off-by: Mika Penttil? mika.penttila at nextfour.com
>
> ---
>   arch/arm/mm/pageattr.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
> index be7fe4b..9edf6b0 100644
> --- a/arch/arm/mm/pageattr.c
> +++ b/arch/arm/mm/pageattr.c
> @@ -49,6 +49,9 @@ static int change_memory_common(unsigned long addr, int numpages,
>   		WARN_ON_ONCE(1);
>   	}
>
> +	if (!numpages)
> +		return 0;
> +
>   	if (start < MODULES_VADDR || start >= MODULES_END)
>   		return -EINVAL;
>
>

Reviewed-by: Laura Abbott <labbott@redhat.com>
