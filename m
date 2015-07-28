From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 29 Jul 2015 00:06:55 +0200
Subject: [PATCH v2 3/6] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <1437990272-23111-4-git-send-email-lee.jones@linaro.org>
References: <1437990272-23111-1-git-send-email-lee.jones@linaro.org>
 <1437990272-23111-4-git-send-email-lee.jones@linaro.org>
Message-ID: <1438121215.30903.27.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ma, 2015-07-27 at 10:44 +0100, Lee Jones wrote:
> --- /dev/null
> +++ b/drivers/mailbox/mailbox-sti.c

> +static int sti_mbox_probe(struct platform_device *pdev)
> +{
> +	[...]
> +
> +	match = of_match_device(sti_mailbox_match, &pdev->dev);
> +	if (!match) {
> +		dev_err(&pdev->dev, "No configuration found\n");
> +		return -ENODEV;
> +	}
> +	pdev->dev.platform_data = (struct sti_mbox_pdata *) match->data;
> +
> +	[...]
> +}

> +static struct platform_driver sti_mbox_driver = {
> +	.probe = sti_mbox_probe,
> +	.remove = sti_mbox_remove,
> +	.driver = {
> +		.name = "sti-mailbox",
> +		.of_match_table = sti_mailbox_match,
> +	},
> +};
> +module_platform_driver(sti_mbox_driver);

> +MODULE_ALIAS("platform:mailbox-sti");

It seems this alias is only useful if there's a corresponding struct
platform_device with a "mailbox-sti" .name. I couldn't spot that
platform_device.

Besides, if I read sti_max_probe() correctly, without OF support loading
this module won't accomplish much. So what would another way of
autoloading this module buy you?

Thanks,


Paul Bolle
