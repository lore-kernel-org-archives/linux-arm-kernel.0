From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Apr 2011 09:55:04 -0300
Subject: [PATCH v4] [ARM] MX1: Add ARMadeus Systems APF9328 board support
In-Reply-To: <1303842222-28209-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1303842222-28209-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <BANLkTimoe_v3cud6XRtqz_Q4BS8Si7PMGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/26 Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>:
...
> +static struct resource dm9000_resources[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start ?= MX1_CS4_PHYS + 0x00C00000,
> + ? ? ? ? ? ? ? .end ? ?= MX1_CS4_PHYS + 0x00C00001,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? [1] = {
> + ? ? ? ? ? ? ? .start ?= MX1_CS4_PHYS + 0x00C00002,
> + ? ? ? ? ? ? ? .end ? ?= MX1_CS4_PHYS + 0x00C00003,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> + ? ? ? },
> + ? ? ? [2] = {
> + ? ? ? ? ? ? ? .start ?= IRQ_GPIOB(14),
> + ? ? ? ? ? ? ? .end ? ?= IRQ_GPIOB(14),
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
> + ? ? ? },
> +};

No need to explicitly show the array index. The compiler can count it by itself.

Regards,

Fabio Estevam
