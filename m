From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2011 13:57:17 +0100
Subject: [PATCH v2] at91: remove MTD_NAND_ATMEL_BUSWIDTH_16 option
In-Reply-To: <1302784833-25930-1-git-send-email-plagnioj@jcrosoft.com>
References: <1302712141-6952-1-git-send-email-plagnioj@jcrosoft.com>
	<1302784833-25930-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20110414125716.GI1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 02:40:33PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> +/*
> + * board revision encoding
> + * bit 0:
> + *	0 => nand 8 bit
> + *	1 => nand 16 bit
> + */
> +#define HAVE_NAND_16BIT	(1 << 0)
> +static int inline ek_have_nand_16bit(void)
> +{
> +	return system_rev & HAVE_NAND_16BIT;
> +}
...
> +/*
> + * board revision encoding
> + * bit 0:
> + *	0 => nand 8 bit
> + *	1 => nand 16 bit
> + */
> +#define HAVE_NAND_16BIT	(1 << 0)
> +static int inline cap9adk_have_nand_16bit(void)
> +{
> +	return system_rev & HAVE_NAND_16BIT;
> +}
...
> +/*
> + * board revision encoding
> + * bit 0:
> + *	0 => nand 8 bit
> + *	1 => nand 16 bit
> + */
> +#define HAVE_NAND_16BIT	(1 << 0)
> +static int inline ek_have_nand_16bit(void)
> +{
> +	return system_rev & HAVE_NAND_16BIT;
> +}
...
> +/*
> + * board revision encoding
> + * bit 0:
> + *	0 => nand 8 bit
> + *	1 => nand 16 bit
> + */
> +#define HAVE_NAND_16BIT	(1 << 0)
> +static int inline ek_have_nand_16bit(void)
> +{
> +	return system_rev & HAVE_NAND_16BIT;
> +}
...
> +/*
> + * board revision encoding
> + * bit 0:
> + *	0 => nand 8 bit
> + *	1 => nand 16 bit
> + */
> +#define HAVE_NAND_16BIT	(1 << 0)
> +static int inline ek_have_nand_16bit(void)
> +{
> +	return system_rev & HAVE_NAND_16BIT;
> +}
...
>  /*
>   * board revision encoding
>   * bit 0:
> - * 	0 => 1 sd/mmc slot
> - * 	1 => 2 sd/mmc slots connectors (board from revision C)
> + *	0 => 1 sd/mmc slot
> + *	1 => 2 sd/mmc slots connectors (board from revision C)
> + * bit 1:
> + *	0 => nand 8 bit
> + *	1 => nand 16 bit
>   */
>  #define HAVE_2MMC	(1 << 0)
> +#define HAVE_NAND_16BIT	(2 << 0)
>  static int inline ek_have_2mmc(void)
>  {
>  	return machine_is_at91sam9g20ek_2mmc() || (system_rev & HAVE_2MMC);
>  }
>  
> +static int inline ek_have_nand_16bit(void)
> +{
> +	return system_rev & HAVE_NAND_16BIT;
> +}
...
> +/*
> + * board revision encoding
> + * bit 0:
> + *	0 => nand 8 bit
> + *	1 => nand 16 bit
> + */
> +#define HAVE_NAND_16BIT	(1 << 0)
> +static int inline ek_have_nand_16bit(void)
> +{
> +	return system_rev & HAVE_NAND_16BIT;
> +}

Do we really need six identical bits of code checking bit 0 of the system
revision, which are different from an already established usage?

Please consolidate this down to a single implementation.
