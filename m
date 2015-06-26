From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Jun 2015 22:43:32 +0200
Subject: [PATCH 1/1] pci: xgene: Enable huge outbound bar support
In-Reply-To: <46305464.n5SOjGAhJb@wuerfel>
References: <1435280756-24455-1-git-send-email-dhdang@apm.com>
 <CADaLNDkck5TaG48sjF9y1wrXTzUeVkYOsXw7Dm8a629KqBafFg@mail.gmail.com>
 <46305464.n5SOjGAhJb@wuerfel>
Message-ID: <1674778.6xGik39Z0J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 June 2015 22:35:08 Arnd Bergmann wrote:
> > >
> > > Can you configure one of the two windows as prefetchable for improved performance?
> > >
> > The new huge window will be prefetchable.
> 
> The DT marks it as non-prefetchable, so the kernel will now try to allocate
> space for non-prefetchable BARs from this area, which is a bug. If the second
> memory window is always prefetchable, you have to mark it accordingly in DT,
> to prevent it from being used for normal 64 bit BARs.

Forget what I wrote here, I just remembered that 64-bit BARs are by definition
prefetchable. You should still mark the range accordingly in DT for correct
operation, but it won't be used for non-prefetchable 64-bit BARs if you don't
because they do not exist.

	Arnd
