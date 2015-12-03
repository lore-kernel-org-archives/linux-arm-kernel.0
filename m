From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Dec 2015 12:02:27 +0000
Subject: [PATCH v6 04/19] arm64: change some CONFIG_COMPAT over to use
 CONFIG_AARCH32_EL0 instead
In-Reply-To: <1447795019-30176-5-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-5-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20151203120227.GJ10747@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 12:16:44AM +0300, Yury Norov wrote:
> From: Andrew Pinski <apinski@cavium.com>
> 
> Reviewed-by: David Daney <ddaney@caviumnetworks.com>
> 
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>

Please add a long description to every patch, even if it is trivial.

And a nitpick: remove the empty lines between Reviewed-by and
Signed-off-by. These tags usually come in the same block.

> +#else
> +
> +typedef elf_greg_t			compat_elf_greg_t;
> +typedef elf_gregset_t			compat_elf_gregset_t;
> +#define compat_a32_elf_check_arch(x)	0
> +#define COMPAT_SET_PERSONALITY(ex)
> +#define COMPAT_ARCH_DLINFO
> +
> +#endif

Do you need these definitions here? I guess they may be used later by
the ILP32 code paths but for A32 compat they don't make much sense (I
haven't made it to the end of the series yet).

-- 
Catalin
