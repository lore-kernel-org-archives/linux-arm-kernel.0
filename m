From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:23:27 +0100
Subject: [PATCH] Smack: fix netfilter Makefile entry
In-Reply-To: <54C927E3.6000006@cogentembedded.com>
References: <2504358.ZeqdfUXKpJ@wuerfel> <54C927E3.6000006@cogentembedded.com>
Message-ID: <30287261.Lan5Co1lCn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 January 2015 21:18:11 Sergei Shtylyov wrote:
> > diff --git a/security/smack/Makefile b/security/smack/Makefile
> > index 616cf93b368e..d4a376c84050 100644
> > --- a/security/smack/Makefile
> > +++ b/security/smack/Makefile
> > @@ -5,4 +5,4 @@
> >   obj-$(CONFIG_SECURITY_SMACK) := smack.o
> >
> >   smack-y := smack_lsm.o smack_access.o smackfs.o
> > -smack-$(CONFIG_NETFILTER) += smack_netfilter.o
> > +smack-$(SECURITY_SMACK_NETFILTER) += smack_netfilter.o
> 
>     CONFIG_ missing?

Yes, you are right. Anyway, as another fix is already queued,
it doesn't matter any more.

	Arnd
