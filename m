From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Jan 2013 22:43:57 +0300
Subject: [PATCH v6] ARM: mtd: nand: davinci: add OF support for davinci
 nand controller
In-Reply-To: <1343632944-25971-1-git-send-email-hs@denx.de>
References: <1343632944-25971-1-git-send-email-hs@denx.de>
Message-ID: <50E48DFD.2030908@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/30/2012 11:22 AM, Heiko Schocher wrote:

> add OF support for the davinci nand controller.

> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-mtd at lists.infradead.org
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Scott Wood <scottwood@freescale.com>

[...]

> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
> index d94b03c..f386b3c 100644
> --- a/drivers/mtd/nand/davinci_nand.c
> +++ b/drivers/mtd/nand/davinci_nand.c
[...]
> @@ -518,9 +519,75 @@ static struct nand_ecclayout hwecc4_2048 __initconst = {
>  	},
>  };
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id davinci_nand_of_match[] = {
> +	{.compatible = "ti,davinci-nand", },
> +	{},
> +}

   I have only one question: have you ever try to compile this patch with
CONFIG_OF enabled? If you have, you would have noticed:

drivers/mtd/nand/davinci_nand.c:527: error: expected ?,? or ?;? before ?extern?

> +MODULE_DEVICE_TABLE(of, davinci_nand_of_match);

   No need to worry now, I'll send out the trivial patch...

WBR, Sergei
