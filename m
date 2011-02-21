From: charu@ti.com (Varadarajan, Charulatha)
Date: Mon, 21 Feb 2011 13:10:59 +0530
Subject: [PATCH resend] omap: rx51: Add SI4713 FM transmitter
In-Reply-To: <1298270556-11571-1-git-send-email-jhnikula@gmail.com>
References: <1298040354-1726-1-git-send-email-jhnikula@gmail.com>
	<1298270556-11571-1-git-send-email-jhnikula@gmail.com>
Message-ID: <AANLkTikR5v9_G3oyRjVP1oCcBo=hU+ikywximd=VDbDd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 12:12, Jarkko Nikula <jhnikula@gmail.com> wrote:
> Add SI4713 FM transmitter supplies, platform data and setup to RX-51/N900.
> It is connected to line output signals of TLV320AIC34 codec A part.
> Driver can be either built-in or a module. It can be tuned with v4l2-ctl
> from ivtv-utils. Following examples illustrate the use of it:
>
> ? ? ? ?v4l2-ctl -d /dev/radio0 --set-ctrl=mute=0 (power up)
> ? ? ? ?v4l2-ctl -d /dev/radio0 -f 107900 (tune 107.9 MHz)
>
> ? ? ? ?v4l2-ctl -d /dev/radio0 --set-ctrl=mute=1 (power down)
>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> Resend = forgot to cc LAKML.
> ---

<<snip>>

> +
> +static __init void rx51_init_si4713(void)
> +{
> + ? ? ? int err;
> +
> + ? ? ? err = gpio_request_one(RX51_FMTX_IRQ, GPIOF_DIR_IN, "si4713 irq");
> + ? ? ? if (err) {
> + ? ? ? ? ? ? ? printk(KERN_ERR "Cannot request si4713 irq gpio. %d\n", err);

use pr_err instead of printk.

> + ? ? ? ? ? ? ? return;
> + ? ? ? }
> + ? ? ? rx51_si4713_board_info.irq = gpio_to_irq(RX51_FMTX_IRQ);
> + ? ? ? platform_device_register(&rx51_si4713_dev);
> +}
> +

<<snip>>
