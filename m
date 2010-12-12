From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 12 Dec 2010 16:49:22 +0300
Subject: [PATCH v2] ata: pata_at91.c bugfix for high master clock
In-Reply-To: <1292099846-24528-1-git-send-email-plyatov@gmail.com>
References: <1292099846-24528-1-git-send-email-plyatov@gmail.com>
Message-ID: <4D04D2E2.20100@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11-12-2010 23:37, Igor Plyatov wrote:

> The AT91SAM9 microcontrollers with master clock higher then 105 MHz
> and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
> lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and driver
> does not detect ATA device.

> Signed-off-by: Igor Plyatov<plyatov@gmail.com>
[...]

> diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
> index 0da0dcc..a462405 100644
> --- a/drivers/ata/pata_at91.c
> +++ b/drivers/ata/pata_at91.c
[...]
> @@ -50,7 +52,7 @@ struct at91_ide_info {
>   };
>
>   static const struct ata_timing initial_timing =
> -	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
> +	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 0, 600, 0};

    BTW, you haven't described this in the changelog...

WBR, Sergei
