From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 31 Oct 2013 11:21:51 +0900
Subject: [PATCH v3 2/4] AArch64: KGDB: Add Basic KGDB support
In-Reply-To: <1382094469-7971-3-git-send-email-vijay.kilari@gmail.com>
References: <1382094469-7971-1-git-send-email-vijay.kilari@gmail.com>
 <1382094469-7971-3-git-send-email-vijay.kilari@gmail.com>
Message-ID: <5271BEBF.2010100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/18/2013 08:07 PM, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
>
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> new file mode 100644
> index 0000000..50cef79
> --- /dev/null
> +++ b/arch/arm64/kernel/kgdb.c
 > ...
> +int kgdb_arch_handle_exception(int exception_vector, int signo,
> +			       int err_code, char *remcom_in_buffer,
> +			       char *remcom_out_buffer,
> +			       struct pt_regs *linux_regs)
> +{
> +	unsigned long addr;
> +	char *ptr;
> +	int err;
> +
> +	switch (remcom_in_buffer[0]) {
> +	case 'D':
> +	case 'k':
> +	case 'c':
> +		/*
> +		 * Packet D (Detach), k (kill) & c (Continue) requires
> +		 * to continue executing. Set pc to required address.
> +		 * Try to read optional parameter, pc unchanged if no parm.

Are you sure that there may be an option parameter even in 'D' or 'k'?
'D' means "detach" and 'k' means "kill", AFAIK, they don't take any
parameters. No other architectures (except arm) handle the case
in such way, neither.

-Takahiro AKASHI
