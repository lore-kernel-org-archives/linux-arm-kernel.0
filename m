From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 20 Jan 2014 17:14:04 -0200
Subject: [PATCH 1/3] mmc: add support for power-on sequencing through DT
In-Reply-To: <1390190215-22700-2-git-send-email-olof@lixom.net>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
Message-ID: <CAOMZO5A=tdzq8SW7P-D_Lxd6Ptjqkk+bKn29T2ggOZar=r4X+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 1:56 AM, Olof Johansson <olof@lixom.net> wrote:

> +Card power and reset control:
> +The following properties can be specified for cases where the MMC
> +peripheral needs additional reset, regulator and clock lines. It is for
> +example common for WiFi/BT adapters to have these separate from the main
> +MMC bus:
> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)

Wouldn't it be better not to assume that the card reset is always
active low and read the GPIO_ACTIVE_xxx flags instead?

Regards,

Fabio Estevam
