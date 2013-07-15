From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Jul 2013 13:14:58 -0300
Subject: [PATCH 13/22] lcd: Add GPIO LCD driver.
In-Reply-To: <1373900227-341-14-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-14-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5C6wKUmK25+7iBX+JGs00RR_hpKrCW3r0un610Z-BZn0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Mon, Jul 15, 2013 at 11:56 AM, Denis Carikli <denis@eukrea.com> wrote:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../bindings/video/backlight/gpio-lcd.txt          |   15 ++
>  drivers/video/backlight/Kconfig                    |    8 +
>  drivers/video/backlight/Makefile                   |    1 +
>  drivers/video/backlight/gpio_lcd.c                 |  178 ++++++++++++++++++++
>  4 files changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt
>  create mode 100644 drivers/video/backlight/gpio_lcd.c
>
> diff --git a/Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt b/Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt
> new file mode 100644
> index 0000000..4ff409d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt
> @@ -0,0 +1,15 @@
> +gpio-lcd bindings
> +
> +Required properties:
> +  - compatible: "gpio-lcd"
> +  - gpios: describes the gpio that is used for enabling/disabling the lcd
> +     (see GPIO binding[0] for more details).

Do we really need this?

Why not just use the regulator framework instead?

You can refer to an example here:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/video/mxsfb.c?id=4344429d3d926d219671f607125cff51223a140a

Regards,

Fabio Estevam
