From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 18 May 2015 13:47:06 +0200
Subject: [PATCH v8 01/16] scripts: link-vmlinux: Don't pass page offset to
 kallsyms if XIP Kernel
In-Reply-To: <1431158038-3813-2-git-send-email-mcoquelin.stm32@gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-2-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CALszF6B0=dgSDfLFwDi9YmEzrrNVuYbUnqMu5DmDhhy--emtpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

2015-05-09 9:53 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> When Kernel is executed in place from ROM, the symbol addresses can be
> lower than the page offset.
>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  scripts/link-vmlinux.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 86a4fe7..b055d9d 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -82,7 +82,7 @@ kallsyms()
>                 kallsymopt="${kallsymopt} --all-symbols"
>         fi
>
> -       if [ -n "${CONFIG_ARM}" ] && [ -n "${CONFIG_PAGE_OFFSET}" ]; then
> +       if [ -n "${CONFIG_ARM}" ] && [ -z "${CONFIG_XIP_KERNEL}" ] && [ -n "${CONFIG_PAGE_OFFSET}" ]; then
>                 kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
>         fi
>
> --
> 1.9.1
>

The get_maintainer.pl does not explicitly provide your name as
maintainer for this file.
But looking at MAINTAINERS file, I think you are the one for it.

Do you confirm?
If this is the case and you agree with the patch, could you consider
taking it for v4.2?

Thanks in advance,
Maxime
