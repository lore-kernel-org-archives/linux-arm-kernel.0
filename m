From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 8 Jan 2016 02:45:43 +0300
Subject: [PATCH v6 11/21] arm64: ilp32: introduce binfmt_ilp32.c
In-Reply-To: <1452209679-19445-12-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <1452209679-19445-12-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160107234543.GA19526@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 02:34:29AM +0300, Yury Norov wrote:
> to handle ILP32 binaries
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
[...]
> diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
> new file mode 100644
> index 0000000..02a7a6c
> --- /dev/null
> +++ b/arch/arm64/kernel/binfmt_ilp32.c
> @@ -0,0 +1,21 @@
> +/*
> + * Support for ILP32 Linux/aarch64 ELF binaries.
> + */
> +
> +/* AARCH64 ILP32 EABI. */
> +#define compat_elf_check_arch(x)	(((x)->e_machine == EM_AARCH64)	\
> +					&& (x)->e_ident[EI_CLASS] == ELFCLASS32)
> +

Not sure about this. Originally it was just:
        #define compat_elf_check_arch(x)	(((x)->e_machine == EM_AARCH64)	\

But how than distinguish aarch64 and aarch64/ilp32 elfs? 
