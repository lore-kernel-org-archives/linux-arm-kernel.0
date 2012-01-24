From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Jan 2012 00:37:50 -0200
Subject: [PATCH V3 4/4] CS89x0 : add CS89x0 platform device to the
 iMX31ADS board
In-Reply-To: <1326571095-27921-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1326571095-27921-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <CAOMZO5CH_3hEHm6=734KoYcURbGf5=BqY3eZKnwkdyFRWMDjAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2012 at 5:58 PM, Jaccon Bastiaansen
<jaccon.bastiaansen@gmail.com> wrote:

> +static const struct resource mx31ads_cs8900_resources[] __initconst = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .start = MX31_CS4_BASE_ADDR + CS4_CS8900_MMIO_START,
> + ? ? ? ? ? ? ? .end = MX31_CS4_BASE_ADDR + CS4_CS8900_MMIO_END,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_MEM
> + ? ? ? },

You can use DEFINE_RES_MEM(MX31_CS4_BASE_ADDR, SZ_64K);
> + ? ? ? {
> + ? ? ? ? ? ? ? .start = EXPIO_INT_ENET_INT,
> + ? ? ? ? ? ? ? .end = EXPIO_INT_ENET_INT,
> + ? ? ? ? ? ? ? .flags = IORESOURCE_IRQ
> + ? ? ? }

And here DEFINE_RES_IRQ(EXPIO_INT_ENET_INT);

Regards,

Fabio Estevam
