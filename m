From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 10:56:06 +0000
Subject: [PATCH 2/2] USB: EHCI: make ehci-orion a separate driver
In-Reply-To: <CAJFYCKGCNDTSq9OYZUYXx8XNSgSHD=p=hw+9_7N=EhM=bUu=bg@mail.gmail.com>
References: <1360966349-1242560-2-git-send-email-arnd@arndb.de>
 <Pine.LNX.4.44L0.1302181723540.6790-100000@netrider.rowland.org>
 <CAJFYCKGCNDTSq9OYZUYXx8XNSgSHD=p=hw+9_7N=EhM=bUu=bg@mail.gmail.com>
Message-ID: <201302191056.07139.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 February 2013, Manjunath Goudar wrote:
> > This is not necessary; ehci_setup is the default value anyway.  This
> > structure can be omitted.
> >
> 
> ehci_init_driver function we are passing orion_overrides,if we are removing
> above struct initialization, what should we need to pass in
> the  ehci_init_driver function.
> 

ehci_init_driver already checks if you pass an override in there, and does
not override anything in that case, so you can simply pass NULL as the
argument.

	Arnd
