From: marex@denx.de (Marek Vasut)
Date: Tue, 26 Nov 2013 22:25:43 +0100
Subject: [PATCH 6/7] PCI: imx6: Fix link start operation
In-Reply-To: <1385500248-6551-6-git-send-email-marex@denx.de>
References: <1385500248-6551-1-git-send-email-marex@denx.de>
 <1385500248-6551-6-git-send-email-marex@denx.de>
Message-ID: <201311262225.43711.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek Vasut,

> This patch first forces the link into Gen1 mode before starting up
> the link and only after the link is up requests the link to start
> negotiating possible Gen2 mode operation. This is because without
> such sequence, some PCIe switches are not detected at all.

[...]

> +	/* Make sure link training is finished as well! */
> +	if (count)
> +		ret = imx6_pcie_wait_for_link(pp);
> +	else
> +		ret = -EINVAL;
> 
> +	if (ret) {
> +		dev_err(pp->dev, "Failed to bring link up!\n");
> +	} else {
> +		tmp = readl(pp->dbi_base + 0x80);
> +		dev_err(pp->dev, "Link up, Gen=%i\n", (tmp >> 16) & 0xf);

Hm meh, this dev_err() shouldn't be here of course. But I'd be interested if you 
people now get stable Gen2 link up properly all the time. Please test. Thanks!

[...]
Best regards,
Marek Vasut
