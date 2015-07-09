From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 09 Jul 2015 22:19:08 +0200
Subject: [PATCH v2] coresight: replicator: Use module_platform_driver
In-Reply-To: <20150709195944.GA4470@vaishali-Ideapad-Z570>
References: <20150709195944.GA4470@vaishali-Ideapad-Z570>
Message-ID: <1436473148.20619.116.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On vr, 2015-07-10 at 01:29 +0530, Vaishali Thakkar wrote:
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c

> -static int __init replicator_init(void)
> -{
> -	return platform_driver_register(&replicator_driver);
> -}
> -module_init(replicator_init);
> -
> -static void __exit replicator_exit(void)
> -{
> -	platform_driver_unregister(&replicator_driver);
> -}
> -module_exit(replicator_exit);
> +module_platform_driver(replicator_driver);

coresight-replicator.o is built if CONFIG_CORESIGHT_LINKS_AND_SINKS is
defined. CORESIGHT_LINKS_AND_SINKS is a bool symbol. It depends on
CORESIGHT, which is also a bool symbol. CORESIGHT is a top level symbol,
available on arm and arm64.

I think coresight-replicator.o can only be built-in. So I suggest to use
builtin_platform_driver() instead.

Thanks,


Paul Bolle
