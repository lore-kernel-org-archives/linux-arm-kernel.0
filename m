From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 12:14:46 +0100
Subject: [PATCH V2] ASoC: tegra: use reset framework
In-Reply-To: <1385496767-8307-1-git-send-email-swarren@wwwdotorg.org>
References: <1385496767-8307-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131129111444.GL22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 01:12:47PM -0700, Stephen Warren wrote:
[...]
> +		rst = reset_control_get(&pdev->dev,
> +					configlink_mods[i].rst_name);
> +		if (IS_ERR(rst)) {
> +			dev_err(&pdev->dev, "Can't get reset %s\n",
> +				configlink_mods[i].rst_name);
> +			ret = PTR_ERR(rst);
>  			goto err;

In case where this fails, there's no way to re-assert the resets that
have already been deasserted. That's not an issue introduced by this
patch, though, and perhaps something we may not want to care about at
all, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/38f6f464/attachment.sig>
