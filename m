From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 26 Oct 2010 13:33:21 +0900
Subject: [PATCH 1/9] S5PV310: DMA: Add platform devices for PL330 DMACs
In-Reply-To: <1288057238-25377-1-git-send-email-jassisinghbrar@gmail.com>
References: <1288057238-25377-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <023c01cb74c6$ee6404f0$cb2c0ed0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> From: Jassi Brar <jassi.brar@samsung.com>
> 
> Samsung's Soc S5PV310 has three PL330 DMACs. First is dedicated for
> Memory->Memory data transfer while the other two meant for data
> transfer with peripherals.
> Define and add latter two PL330 DMACs as platform devices on the
> S5PV310 platform.
> 
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
> ---

(snip)
> +
> +static struct resource s5pv310_pdma0_resource[] = {
> +	[0] = {
> +		.start = S5PV310_PA_PDMA0,
                      ^
> +		.end = S5PV310_PA_PDMA0 + SZ_4K,
                    ^
> +		.flags = IORESOURCE_MEM,
                      ^
> +	},
> +	[1] = {
> +		.start	= IRQ_PDMA0,
> +		.end	= IRQ_PDMA0,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};

I think tab is better for easily reading and keep the same method in ^ mark.
Actually, as you know, our Samsung arch/arm stuff followed similar method...

> +
> +static struct s3c_pl330_platdata s5pv310_pdma0_pdata = {
> +	.peri = {
> +		[30] = DMACH_MAX,
> +		[31] = DMACH_MAX,
> +		[24] = DMACH_AC97_PCMOUT,
> +		[23] = DMACH_AC97_PCMIN,
> +		[22] = DMACH_AC97_MICIN,
> +		[24] = DMACH_SLIMBUS4_TX,
> +		[23] = DMACH_SLIMBUS4_RX,
> +		[22] = DMACH_SLIMBUS2_TX,
> +		[21] = DMACH_SLIMBUS2_RX,
> +		[20] = DMACH_SLIMBUS0_TX,
> +		[19] = DMACH_SLIMBUS0_RX,
> +		[3] = DMACH_UART4_TX,
> +		[2] = DMACH_UART4_RX,
> +		[5] = DMACH_UART2_TX,
> +		[4] = DMACH_UART2_RX,
> +		[1] = DMACH_UART0_TX,
> +		[0] = DMACH_UART0_RX,
> +		[13] = DMACH_I2S2_TX,
> +		[12] = DMACH_I2S2_RX,
> +		[10] = DMACH_I2S0_TX,
> +		[9] = DMACH_I2S0_RX,
> +		[11] = DMACH_I2S0S_TX,
> +		[19] = DMACH_SPI2_TX,
> +		[18] = DMACH_SPI2_RX,
> +		[17] = DMACH_SPI0_TX,
> +		[16] = DMACH_SPI0_RX,
> +		[5] = DMACH_MSM_REQ2,
> +		[4] = DMACH_MSM_REQ0,
> +		[3] = DMACH_PCM2_TX,
> +		[2] = DMACH_PCM2_RX,
> +		[1] = DMACH_PCM0_TX,
> +		[0] = DMACH_PCM0_RX,

As you know...maybe need to fix.

(snip)

I think, we can merge platform_device of DMA for S5P SoCs which have same
PL330 DMAC later. And various platform_data can be handled on each SoC part.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
