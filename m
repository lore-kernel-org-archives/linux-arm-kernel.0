From: tj@kernel.org (Tejun Heo)
Date: Sun, 15 Jan 2017 18:12:08 -0500
Subject: [PATCH 06/10] sata: ahci_da850: implement a softreset quirk
In-Reply-To: <1484311084-31547-7-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-7-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <20170115231208.GD14446@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 01:38:00PM +0100, Bartosz Golaszewski wrote:
> +static int ahci_da850_softreset(struct ata_link *link,
> +				unsigned int *class, unsigned long deadline)
> +{
> +	int pmp, ret;
> +
> +	pmp = sata_srst_pmp(link);
> +
> +	ret = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
> +	if (pmp && ret == -EBUSY)
> +		return ahci_do_softreset(link, class, 0,
> +					 deadline, ahci_check_ready);
> +
> +	return ret;
> +}

Please add some comments explaining what's going on.

Thanks.

-- 
tejun
