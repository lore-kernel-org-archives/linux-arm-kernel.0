From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Jan 2011 12:38:26 -0800
Subject: [PATCH v2 18/28] ARM: tegra: add CPU_IDLE driver
In-Reply-To: <1295834493-5019-19-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-19-git-send-email-ccross@android.com>
Message-ID: <4D41D7C2.3080608@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2011 06:01 PM, Colin Cross wrote:
>
> +static int __init tegra_cpuidle_debug_init(void)
> +{
> +	struct dentry *dir;
> +	struct dentry *d;
> +
> +	dir = debugfs_create_dir("cpuidle", NULL);
> +	if (!dir)
> +		return -ENOMEM;
> +
> +	d = debugfs_create_file("lp2", S_IRUGO, dir, NULL,
> +		&tegra_lp2_debug_ops);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +#endif
> +
> +late_initcall(tegra_cpuidle_debug_init);

Will this compile with CONFIG_DEBUG_FS=n?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
