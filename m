From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Jun 2010 19:59:04 +0800
Subject: [PATCH 5/6] [ARM] shmobile: change __io() definition to use
	__typesafe_io()
In-Reply-To: <1277293938-25804-6-git-send-email-eric.y.miao@gmail.com>
References: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
	<1277293938-25804-6-git-send-email-eric.y.miao@gmail.com>
Message-ID: <AANLkTikqB-TPT5qNbkrmNfG0GQpJmc6MNcJd4Up1FFKi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 7:52 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Signed-off-by: Eric Miao <eric.miao@canonical.com>

Sorry, forgot to CC Magnus.

> ---
> ?arch/arm/mach-shmobile/include/mach/io.h | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/include/mach/io.h b/arch/arm/mach-shmobile/include/mach/io.h
> index 3e29649..19d5120 100644
> --- a/arch/arm/mach-shmobile/include/mach/io.h
> +++ b/arch/arm/mach-shmobile/include/mach/io.h
> @@ -1,5 +1,5 @@
> ?#ifndef __ASM_MACH_IO_H
> ?#define __ASM_MACH_IO_H
>
> -#define __io(a) ? ? ? ? ? ? ? ? ? ? ? ?((void __iomem *)(a))
> +#define __io(a) ? ? ? ? ? ? ? ? ? ? ? ?__typesafe_io(a)
> ?#endif /* __ASM_MACH_IO_H */
> --
> 1.7.1
>
>
