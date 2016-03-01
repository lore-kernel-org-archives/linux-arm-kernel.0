From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Mar 2016 22:21:19 +0100
Subject: [PATCH] target/cxgbit: add INET dependency
In-Reply-To: <1456810108.19657.187.camel@haakon3.risingtidesystems.com>
References: <1456744504-3011977-1-git-send-email-arnd@arndb.de>
 <1456810108.19657.187.camel@haakon3.risingtidesystems.com>
Message-ID: <2941855.lXKcTvDzjQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 21:28:28 Nicholas A. Bellinger wrote:
> > diff --git a/drivers/target/iscsi/cxgbit/Kconfig b/drivers/target/iscsi/cxgbit/Kconfig
> > index cf335b4dbb4e..ce6f5cca315d 100644
> > --- a/drivers/target/iscsi/cxgbit/Kconfig
> > +++ b/drivers/target/iscsi/cxgbit/Kconfig
> > @@ -1,6 +1,7 @@
> >  config ISCSI_TARGET_CXGB4
> >       tristate "Chelsio iSCSI target offload driver"
> >       depends on ISCSI_TARGET && CHELSIO_T4
> > +     depends on INET
> >       select CHELSIO_T4_UWIRE
> >       ---help---
> >       To compile this driver as module, choose M here: the module
> 
> Odd, ISCSI_TARGET already depends on NET, but I guess that's not enough
> for cxgbit..  ;)
> 

The problem is that you can have CONFIG_NET=y but CONFIG_INET=n

It would probably be reasonable to make the ISCSI_TARGET option depend
on CONFIG_INET directly, which would solve the problem as well.

	Arnd
