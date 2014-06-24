From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 16:08:15 +0200
Subject: [PATCH 1/4] phy: miphy365x: Add Device Tree bindings for the
 MiPHY365x
In-Reply-To: <20140624124634.GO13803@lee--X1>
References: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
 <6599289.0ZjjaMbRqj@wuerfel> <20140624124634.GO13803@lee--X1>
Message-ID: <4274516.nCpbjAuUJp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 13:46:34 Lee Jones wrote:
> > > > > converting all addresses to to resources so drivers can easily pull
> > > > > them out using platform_get_resource() and friends.  Pushing the reg
> > > > 
> > > > right. Can't we use of_address_to_resource here?
> > > 
> > > We could, but that would be an extra layer.  We'd be pulling the
> > > address, putting it into a resource, then pulling it from the resource
> > > for use.  If we're going to be pulling addresses out manually, we're
> > > probably better off using of_get_address().  But again, we're just
> > > carrying out functionality which is already provided by the
> > > framework.
> > 
> > there is also of_ioremap().
> 
> Isn't this SPARK only?  And doesn't it require a populated resource?  
> Which is what I'm saying is the issue here i.e. we don't have one.

Sorry, I meant of_iomap(). I think it's only for historic reaons
that we have both. Probably of_iomap started out on powerpc with
the same intention as the sparc of_ioremap.

of_iomap does not require a resource, just an index.

	Arnd
