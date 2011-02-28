From: pratheesh@ti.com (TK, Pratheesh Gangadhar)
Date: Mon, 28 Feb 2011 18:34:10 +0530
Subject: [PATCH v2 02/13] da850: pruss platform specific additions.
In-Reply-To: <1297435892-28278-3-git-send-email-subhasish@mistralsolutions.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-3-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BF35DEE@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: davinci-linux-open-source-bounces at linux.davincidsp.com
> [mailto:davinci-linux-open-source-bounces at linux.davincidsp.com] On Behalf
> Of Subhasish Ghosh
> Sent: Friday, February 11, 2011 8:21 PM
> To: davinci-linux-open-source at linux.davincidsp.com
> Cc: sachi at mistralsolutions.com; Russell King; Kevin Hilman; Subhasish
> Ghosh; open list; Watkins, Melissa; linux-arm-kernel at lists.infradead.org
> Subject: [PATCH v2 02/13] da850: pruss platform specific additions.
> 
> This patch adds the platform device and assignes the platform resources
> for the PRUSS mfd driver.
> 
> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
> ---
> +struct platform_device da8xx_pruss_dev = {
Can you please rename this to da8xx_pruss_mfddev?
> +	.name		= "da8xx_pruss",
Can you please rename name string as pruss_mfd? This will help to
base my UIO patches on top of yours.
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(da8xx_pruss_resources),
> +	.resource	= da8xx_pruss_resources,
> +};
> +
> +int __init da8xx_register_pruss(struct da8xx_pruss_devices *pruss_device)
Please rename this to da8xx_register_pruss_mfd

Thanks,
Pratheesh
