From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 23 Feb 2011 20:20:27 +0530
Subject: [PATCH v3 7/9] davinci: add spi devices support for
	MityDSP-L138/MityARM-1808 platform
In-Reply-To: <1298381824-7723-8-git-send-email-michael.williamson@criticallink.com>
References: <1298381824-7723-1-git-send-email-michael.williamson@criticallink.com>
	<1298381824-7723-8-git-send-email-michael.williamson@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024BE4914B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, Feb 22, 2011 at 19:07:02, Michael Williamson wrote:

> +static void __init mityomapl138_init_spi1(struct spi_board_info *info,
> +					  unsigned len)
> +{
> +	int ret;
> +
> +	ret = spi_register_board_info(info, len);
> +	if (ret)
> +		pr_warning("%s: failed to register board info : %d\n",
> +				__func__, ret);
> +
> +	da8xx_spi_pdata[1].num_chipselect = len;
> +
> +	ret = da8xx_register_spi(1);
> +	if (ret)
> +		pr_warning("%s: failed to register spi 1 device : %d\n",
> +				__func__, ret);
> +}

I missed this previously. We seem to be adding this boilerplate
evm init function for every board. It will be worthwhile to
modify the da8xx_register_spi() function to take in the info and
num_chipselect too. The same function can then be called by each
evm.

Sorry about trickling in the comments - this should be the last
one ;) I have added the first five patches of the series to the
branch here:

http://arago-project.org/git/projects/?p=linux-davinci.git;a=shortlog;h=refs/heads/next-for-kevin

You can rebase to this branch so you will have to spin only the
modified patches again.

Thanks,
Sekhar
