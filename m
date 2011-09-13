From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 13 Sep 2011 12:03:36 -0700
Subject: [PATCH 08/11] clk: Avoid clock name collisions
In-Reply-To: <1314191759-16941-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1314191759-16941-8-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <4E6FA908.9010002@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/11 06:15, Mark Brown wrote:
> +	if (dev) {
> +		name_len = strlen(name) + strlen(dev_name(dev)) + 2;
> +		new_name = kzalloc(name_len, GFP_KERNEL);
> +		if (!new_name)
> +			goto err;
> +
> +		snprintf(new_name, name_len, "%s-%s", dev_name(dev), name);
> +

Perhaps use kasprintf() instead?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
