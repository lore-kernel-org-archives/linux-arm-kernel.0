From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Mon, 09 Aug 2010 21:04:48 +0200
Subject: [PATCH 4/8] ARM i.MX: add SDMA driver
In-Reply-To: <1281344743-2029-5-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4C605150.7030403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Just some typos that I spotted.

> diff --git a/arch/arm/plat-mxc/include/mach/sdma.h b/arch/arm/plat-mxc/include/mach/sdma.h
> new file mode 100644
> index 0000000..5d542b8
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/sdma.h
> @@ -0,0 +1,8 @@
> +#ifndef __MACH_MXC_SDMA_H__
> +#define __MACH_MXC_SDMA_H__
> +
> +struct sdma_platform_data {
> +	int sdma_version;
> +};
> +
> +#endif /* __MACH_MXC_SDMA_H__ */
> diff --git a/arch/arm/plat-mxc/sdma.c b/arch/arm/plat-mxc/sdma.c
> new file mode 100644
> index 0000000..3fbc8d8
> --- /dev/null
> +++ b/arch/arm/plat-mxc/sdma.c
...

> +#ifdef __BIG_ENDIAN
> +struct sdma_mode_count {
> +	u32 command :  8; /* command mostlky used for channel 0 */
                                        ^^^ typo

> +	u32 status  :  8; /* E,R,I,C,W,D status bits stored here */
> +	u32 count   : 16; /* size of the buffer pointed by this BD */
> +};
> +#else
> +struct sdma_mode_count {
> +	u32 count   : 16; /* size of the buffer pointed by this BD */
> +	u32 status  :  8; /* E,R,I,C,W,D status bits stored here */
> +	u32 command :  8; /* command mostlky used for channel 0 */
                                        ^^^ typo

> +};
> +#endif
> +
> +/*
> + * Buffer descriptor
> + */
> +struct sdma_buffer_descriptor {
> +	struct sdma_mode_count  mode;
> +	void *buffer_addr;    /* address of the buffer described */
> +	void *ext_buffer_addr; /* extended buffer address */
> +};
> +
> +/*
> + * Channel control Block
> + */
> +struct sdma_channel_control {
> +	struct sdma_buffer_descriptor *currentBDptr; /* current buffer descriptor processed */
> +	struct sdma_buffer_descriptor *baseBDptr;    /* first element of buffer descriptor array */
> +	void *unused;
> +	void *unused1;
> +};
> +
> +/**
> + * Context structure.
> + */
> +#ifdef __BIG_ENDIAN
> +struct sdma_state_registers {
> +	u32 sf     : 1; /* source falut while loading data */
                                  ^^^^^ typo?

> +	u32 unused0: 1;
> +	u32 rpc    :14; /* return program counter */
> +	u32 t      : 1; /* test bit:status of arithmetic & test instruction*/
> +	u32 unused1: 1;
> +	u32 pc     :14; /* program counter */
> +	u32 lm     : 2; /* loop mode */
> +	u32 epc    :14; /* loop end program counter */
> +	u32 df     : 1; /* destiantion falut while storing data */
                           ^^^^^^^^^^^^^^^^^ typos

> +	u32 unused2: 1;
> +	u32 spc    :14; /* loop start program counter */
> +};
> +#else
> +struct sdma_state_registers {
> +	u32 pc     :14; /* program counter */
> +	u32 unused1: 1;
> +	u32 t      : 1; /* test bit: status of arithmetic & test instruction*/
> +	u32 rpc    :14; /* return program counter */
> +	u32 unused0: 1;
> +	u32 sf     : 1; /* source falut while loading data */
                                    ^^^ typo?

Regards, Magnus Lilja
