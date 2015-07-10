From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Fri, 10 Jul 2015 08:53:27 +0530
Subject: [PATCH v2] coresight: replicator: Use module_platform_driver
In-Reply-To: <1436473148.20619.116.camel@tiscali.nl>
References: <20150709195944.GA4470@vaishali-Ideapad-Z570>
 <1436473148.20619.116.camel@tiscali.nl>
Message-ID: <CAK-LDb+HSbM2zV8WxipLb8v7g+eL=5vMHcKGttEOdnCjSXSwPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 1:49 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
>
> On vr, 2015-07-10 at 01:29 +0530, Vaishali Thakkar wrote:
> > --- a/drivers/hwtracing/coresight/coresight-replicator.c
> > +++ b/drivers/hwtracing/coresight/coresight-replicator.c
>
> > -static int __init replicator_init(void)
> > -{
> > -     return platform_driver_register(&replicator_driver);
> > -}
> > -module_init(replicator_init);
> > -
> > -static void __exit replicator_exit(void)
> > -{
> > -     platform_driver_unregister(&replicator_driver);
> > -}
> > -module_exit(replicator_exit);
> > +module_platform_driver(replicator_driver);
>
> coresight-replicator.o is built if CONFIG_CORESIGHT_LINKS_AND_SINKS is
> defined. CORESIGHT_LINKS_AND_SINKS is a bool symbol. It depends on
> CORESIGHT, which is also a bool symbol. CORESIGHT is a top level symbol,
> available on arm and arm64.
>
> I think coresight-replicator.o can only be built-in. So I suggest to use
> builtin_platform_driver() instead.
>

I thought about this solution before sending this patch. But I was not
sure about it. Thanks for the explanation. I will send v3 with this
change.

Can I add Suggested By: Paul Bolle <pebolle@tiscali.nl>


>
> Thanks,
>
>
> Paul Bolle




-- 
Vaishali
