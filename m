From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 30 Jun 2013 21:12:25 -0700 (PDT)
Subject: [PATCH 2/3] ARM: shmobile: r8a7778: add HPB-DMAC support
In-Reply-To: <201306300248.57898.sergei.shtylyov@cogentembedded.com>
References: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
 <201306300248.57898.sergei.shtylyov@cogentembedded.com>
Message-ID: <87d2r2j4uy.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> From: Max Filippov <max.filippov@cogentembedded.com>
> 
> Add HPB-DMAC platform device on R8A7778 SoC along with its slave and channel
> configurations.
> 
> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
(snip)
> +static const struct hpb_dmae_slave_config hpb_dmae_slaves[] = {
> +	{
> +		.id	= HPBDMA_SLAVE_SDHI0_TX,
> +		.addr	= 0xffe4c000 + 0x30,
> +		.dcr	= DCR_SPDS_16BIT | DCR_DMDL | DCR_DPDS_16BIT,
> +		.rstr	= ASYNCRSTR_ASRST21 | ASYNCRSTR_ASRST22 |
> +			  ASYNCRSTR_ASRST23,
> +		.mdr	= ASYNCMDR_ASMD21_SINGLE,
> +		.mdm	= ASYNCMDR_ASMD21_MASK,
> +		.port	= 0x0D0C,
> +		.flags	= HPB_DMAE_SET_ASYNC_RESET | HPB_DMAE_SET_ASYNC_MODE,
> +		.dma_ch	= 21,
> +	}, {
> +		.id	= HPBDMA_SLAVE_SDHI0_RX,
> +		.addr	= 0xffe4c000 + 0x30,
> +		.dcr	= DCR_SMDL | DCR_SPDS_16BIT | DCR_DPDS_16BIT,
> +		.rstr	= ASYNCRSTR_ASRST21 | ASYNCRSTR_ASRST22 |
> +			  ASYNCRSTR_ASRST23,
> +		.mdr	= ASYNCMDR_ASMD22_SINGLE,
> +		.mdm	= ASYNCMDR_ASMD22_MASK,
> +		.port	= 0x0D0C,
> +		.flags	= HPB_DMAE_SET_ASYNC_RESET | HPB_DMAE_SET_ASYNC_MODE,
> +		.dma_ch	= 22,
> +	}, {
> +		.id	= HPBDMA_SLAVE_SSI0_TX_ST,
> +		.addr	= 0xffd90000 + 0x1008,
> +		.dcr	= DCR_CT | DCR_DIP | DCR_SPDS_32BIT | DCR_DMDL |
> +			  DCR_DPDS_32BIT,
> +		.port	= 0x0000,
> +		.dma_ch	= 28,
> +	}, {
> +		.id	= HPBDMA_SLAVE_SSI0_TX_MN,
> +		.addr	= 0xffd90000 + 0x1008,
> +		.dcr	= DCR_CT | DCR_DIP | DCR_SPDS_16BIT | DCR_DMDL |
> +			  DCR_DPDS_16BIT,
> +		.port	= 0x0000,
> +		.dma_ch	= 28,
> +	}, {
> +		.id	= HPBDMA_SLAVE_SSI1_RX_ST,
> +		.addr	= 0xffd90000 + 0x104c,
> +		.dcr	= DCR_CT | DCR_DIP | DCR_SMDL | DCR_SPDS_32BIT |
> +			  DCR_DPDAM | DCR_DPDS_32BIT,
> +		.port	= 0x0101,
> +		.dma_ch	= 29,
> +	}, {
> +		.id	= HPBDMA_SLAVE_SSI1_RX_MN,
> +		.addr	= 0xffd90000 + 0x104c,
> +		.dcr	= DCR_CT | DCR_DIP | DCR_SMDL | DCR_SPDS_16BIT |
> +			  DCR_DPDAM | DCR_DPDS_16BIT,
> +		.port	= 0x0101,
> +		.dma_ch	= 29,
> +	},
> +};

How did you test SSI ?
remove these

Best regards
---
Kuninori Morimoto
