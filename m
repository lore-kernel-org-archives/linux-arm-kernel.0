From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Thu, 02 May 2013 14:37:18 -0300
Subject: [PATCH, RFC 22/22] radio-si4713: depend on SND_SOC
In-Reply-To: <1367507786-505303-23-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-23-git-send-email-arnd@arndb.de>
Message-ID: <5182A44E.7080701@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em 02-05-2013 12:16, Arnd Bergmann escreveu:
> It is not possible to select SND_SOC_SI476X if we have not also
> enabled SND_SOC.
>
> warning: (RADIO_SI476X) selects SND_SOC_SI476X which has unmet
> 	 direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC)
>
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: linux-media at vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/media/radio/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
> index c0beee2..d529ba7 100644
> --- a/drivers/media/radio/Kconfig
> +++ b/drivers/media/radio/Kconfig
> @@ -22,6 +22,7 @@ config RADIO_SI476X
>   	tristate "Silicon Laboratories Si476x I2C FM Radio"
>   	depends on I2C && VIDEO_V4L2
>   	depends on MFD_SI476X_CORE
> +	depends on SND_SOC
>   	select SND_SOC_SI476X
>   	---help---
>   	  Choose Y here if you have this FM radio chip.
>

Do you prefer to send it via your tree or via mine? Either way works for me.

If you're willing to send it via your tree:

Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>
