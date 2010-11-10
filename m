From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 10 Nov 2010 19:49:39 +0300
Subject: [PATCH 3/6] omap:mailbox-fix checkpatch warnings
In-Reply-To: <1289393121-7911-4-git-send-email-h-kanigeri2@ti.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
	<1289393121-7911-4-git-send-email-h-kanigeri2@ti.com>
Message-ID: <4CDACD23.7020609@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Hari Kanigeri wrote:

> Fix the checkpatch warnings observed in mailbox module

> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/plat-omap/mailbox.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index 9ce3570..ed960c1 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
[...]
> @@ -394,7 +394,8 @@ static int __init omap_mbox_init(void)
>  
>  	/* kfifo size sanity check: alignment and minimal size */
>  	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(mbox_msg_t));
> -	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(mbox_msg_t));
> +	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size,
> +						sizeof(mbox_msg_t));

    This line is over-indented a bit.

WBR, Sergei
