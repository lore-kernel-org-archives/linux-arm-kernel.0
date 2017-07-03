From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 03 Jul 2017 11:13:04 +0200
Subject: [PATCH v3 02/12] ALSA: ac97: add an ac97 bus
In-Reply-To: <20170630194408.24978-3-robert.jarzmik@free.fr>
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
 <20170630194408.24978-3-robert.jarzmik@free.fr>
Message-ID: <s5hpodhc28v.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Jun 2017 21:43:58 +0200,
Robert Jarzmik wrote:
> +static struct bus_type ac97_bus_type = {
> +	.name		= "ac97",

Name-conflict with the old ac97 bus?

> +	.dev_groups	= ac97_dev_groups,
> +	.match		= ac97_bus_match,
> +	.pm		= &ac97_pm,
> +	.probe		= ac97_bus_probe,
> +	.remove		= ac97_bus_remove,
> +};
> +
> +static int __init ac97_bus_init(void)
> +{
> +	return bus_register(&ac97_bus_type);
> +}
> +subsys_initcall(ac97_bus_init);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");

No bus_unregister() at exit?


thanks,

Takashi
