From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jun 2014 19:02:53 +0200
Subject: [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
 <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <4476889.LvjMyVbGZ8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 June 2014 12:48:10 Ashwin Chaugule wrote:
> 
> +#ifndef CONFIG_ACPI
>         if (!mbox->of_xlate)
>                 mbox->of_xlate = of_mbox_index_xlate;
> -
> +#endif
>         mutex_lock(&con_mutex);
>         list_add_tail(&mbox->node, &mbox_cons);
>         mutex_unlock(&con_mutex);
> 

You can't do #ifndef here, the driver must still work if
both OF and ACPI are enabled.

	Arnd
