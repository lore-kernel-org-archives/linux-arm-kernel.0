From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Aug 2011 09:26:50 +0100
Subject: [PATCH v2 1/7] ARM: mmp: parse irq from DT
In-Reply-To: <1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
References: <1311835293-18125-1-git-send-email-haojian.zhuang@marvell.com>
	<1311835293-18125-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110801082649.GA15578@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 28, 2011 at 02:41:27PM +0800, Haojian Zhuang wrote:
> +	unsigned int status, mask, irq_base, nr, data;
> +	int cascade;
> +
...
> +		mux_info = kzalloc(sizeof(*mux_info), GFP_KERNEL);
> +		if (mux_info == NULL)
> +			goto out;
> +		status += (unsigned int)mmp_info->virt_base;
> +		mux_info->status = (void __iomem *)status;

This is silly.  Why not just do:

		mux_info->status = mmp_info->virt_base + status;

and avoid those horrible casts?
