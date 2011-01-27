From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Jan 2011 11:45:04 -0800
Subject: [PATCH v2 15/28] ARM: tegra: irq: Add debugfs file to show wake
	irqs
In-Reply-To: <1295834493-5019-16-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-16-git-send-email-ccross@android.com>
Message-ID: <4D41CB40.20903@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2011 06:01 PM, Colin Cross wrote:
>
> +static int __init tegra_irq_debug_init(void)
> +{
> +	struct dentry *d;
> +
> +	d = debugfs_create_file("wake_irq", S_IRUGO, NULL, NULL,
> +		&tegra_wake_irq_debug_fops);
> +	if (!d) {
> +		pr_info("Failed to create suspend_mode debug file\n");

Does this want to be a pr_err()?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
