From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 03 Nov 2010 10:15:31 +0100
Subject: [PATCH 2/2] ARM: imx: Add mx53 support to common msl functions.
In-Reply-To: <1288736227-800-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1288736227-800-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1288736227-800-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <4CD12833.8060204@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

Le 02/11/2010 23:17, Dinh.Nguyen at freescale.com a ?crit :
> From: Dinh Nguyen<Dinh.Nguyen@freescale.com>
>
> Add mx53 support to cpu.c and mm.c.
>
> Signed-off by: Dinh Nguyen<Dinh.Nguyen@freescale.com>
>   static void query_silicon_parameter(void)
>   {
> -	void __iomem *rom = ioremap(MX51_IROM_BASE_ADDR, MX51_IROM_SIZE);
> +	void __iomem *rom;
>   	u32 rev;
>
> +	if (cpu_is_mx51())
> +		rom = ioremap(MX51_IROM_BASE_ADDR, MX51_IROM_SIZE);
> +	else if (cpu_is_mx53())
> +		rom = ioremap(MX53_IROM_BASE_ADDR, MX53_IROM_SIZE);
> +
isn't the correct way to get the silicon revision to read the "Product 
Revision register" and "Silicon Revision register" of the IIM and not from the 
internal ROM ? (page 41-11 of the i.MX51 reference manual).

Eric
