From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 24 Apr 2015 10:25:12 +0200
Subject: [PATCH V2 1/4] mailbox: add support for APM X-Gene platform
 mailbox driver
In-Reply-To: <1429741125-29156-2-git-send-email-fkan@apm.com>
References: <1429741125-29156-1-git-send-email-fkan@apm.com>
 <1429741125-29156-2-git-send-email-fkan@apm.com>
Message-ID: <1429863912.2927.43.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-04-22 at 15:18 -0700, Feng Kan wrote:
> --- /dev/null
> +++ b/drivers/mailbox/mailbox-xgene-slimpro.c

> +static struct platform_driver slimpro_mbox_driver = {
> +	.probe	= slimpro_mbox_probe,
> +	.remove = slimpro_mbox_remove,
> +	.driver	= {
> +		.name = "xgene-slimpro-mbox",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(slimpro_of_match),
> +	},
> +};
> +
> +static int __init slimpro_mbox_init(void)
> +{
> +	return platform_driver_register(&slimpro_mbox_driver);
> +}
> +
> +subsys_initcall(slimpro_mbox_init);

After a quick scan of this driver you'd expect something like
    static void __exit slimpro_mbox_exit(void)
    {
	platform_driver_unregister(&slimpro_mbox_driver);
    }
    module_exit(slimpro_mbox_exit);

too here. At least, I do. Is there some non-obvious (to me) reason this
driver can't be unloaded if it is built as a module?

> +MODULE_DESCRIPTION("APM X-Gene SLIMpro Mailbox Driver");
> +MODULE_LICENSE("GPL");

Thanks,


Paul Bolle
