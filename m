From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Dec 2015 11:41:53 +0000
Subject: [PATCH v6 08/20] arm64: ilp32: add is_ilp32_compat_{task,
 thread} and TIF_32BIT_AARCH64
In-Reply-To: <1450215766-14765-9-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-9-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151217114153.GD25232@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 12:42:34AM +0300, Yury Norov wrote:
> Reviewed-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>

Long description missing.

> diff --git a/arch/arm64/include/asm/is_compat.h b/arch/arm64/include/asm/is_compat.h
> index 476db90..89b1f65 100644
> --- a/arch/arm64/include/asm/is_compat.h
> +++ b/arch/arm64/include/asm/is_compat.h
> @@ -36,7 +36,6 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
>  #else
>  
>  static inline int is_a32_compat_task(void)
> -
>  {
>  	return 0;
>  }

You should move this to the previous patch.

> @@ -45,14 +44,39 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
>  {
>  	return 0;
>  }
> -
>  #endif /* CONFIG_AARCH32_EL0 */

Maybe this one as well, though I like an empty line before the last
#endif (i.e. drop this hunk).

-- 
Catalin
