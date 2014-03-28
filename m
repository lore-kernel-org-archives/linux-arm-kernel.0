From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 28 Mar 2014 21:48:23 +0100
Subject: [PATCHv3] net: mvneta: use devm_ioremap_resource() instead of
 of_iomap()
In-Reply-To: <20140328.161007.1937376826264802047.davem@davemloft.net>
References: <1395916769-20475-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140328.161007.1937376826264802047.davem@davemloft.net>
Message-ID: <20140328214823.2d6955e5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear David Miller,

On Fri, 28 Mar 2014 16:10:07 -0400 (EDT), David Miller wrote:
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Date: Thu, 27 Mar 2014 11:39:29 +0100
> 
> > The mvneta driver currently uses of_iomap(), which has two drawbacks:
> > it doesn't request the resource, and it isn't devm-style so some error
> > handling is needed.
> > 
> > This commit switches to use devm_ioremap_resource() instead, which
> > automatically requests the resource (so the I/O registers region shows
> > up properly in /proc/iomem), and also is devm-style, which allows to
> > get rid of some error handling to unmap the I/O registers region.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Does this actually fix any bugs?  It seems like the unmaps happen in
> all the necessary cases.
> 
> If it's just a simplification or cleanup I'm going to apply this to
> net-next.

The patch does not fix any bug, it is simply a cleanup/improvement, and
therefore applying to net-next is perfectly fine for me. Actually, it's
the very reason why I sent it separately from the two other patches
that fix the usage of mvneta as a module, which, them, were really bug
fixes.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
