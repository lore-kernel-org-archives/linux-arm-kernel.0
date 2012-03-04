From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 4 Mar 2012 16:50:52 +0000
Subject: [PATCH 4/5 v2] ARM: kirkwood: convert rtc-mv to fdt.
In-Reply-To: <201203041612.44966.michael@walle.cc>
References: <cover.1330709314.git.jason@lakedaemon.net>
 <4de611961e8210a0a2c3b56fe72b40dba638752a.1330709314.git.jason@lakedaemon.net>
 <201203041612.44966.michael@walle.cc>
Message-ID: <201203041650.52217.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 March 2012, Michael Walle wrote:
> > @@ -294,11 +295,17 @@ static int __exit mv_rtc_remove(struct
> > platform_device *pdev) return 0;
> >  }
> > 
> > +static struct of_device_id rtc_mv_of_match_table[] = {
> > +     { .compatible = "marvell,rtc", },
> > +     {}
> > +};
> > +
> Isn't here an ifdef CONFIG_OF missing to prevent compiler warnings?
> 

Yes, I guess so. I keep thinking that an __unused attribute would
actually be more helpful here because it lets the compiler automatically
discard the symbol when it's not used, but we still get potential
compiler errors and warnings if something inside of the unused data
is broken.

	Arnd
