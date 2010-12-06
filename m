From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 06 Dec 2010 13:07:30 -0800
Subject: [PATCH 14/21] ARM: tegra: irq: Add debugfs file to show wake irqs
In-Reply-To: <1291590548-7341-15-git-send-email-ccross@android.com>
References: <1291590548-7341-1-git-send-email-ccross@android.com>
	<1291590548-7341-15-git-send-email-ccross@android.com>
Message-ID: <4CFD5092.50809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2010 03:09 PM, Colin Cross wrote:
> +static int __init tegra_irq_debug_init(void)
> +{
> +	struct dentry *d;
> +
> +	d = debugfs_create_file("wake_irq", 0755, NULL, NULL,
> +		&tegra_wake_irq_debug_fops);

Why not use S_IRUGO? And why is this file executable?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
