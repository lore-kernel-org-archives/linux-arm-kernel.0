From: davem@davemloft.net (David Miller)
Date: Fri, 28 Mar 2014 16:10:07 -0400 (EDT)
Subject: [PATCHv3] net: mvneta: use devm_ioremap_resource() instead of
 of_iomap()
In-Reply-To: <1395916769-20475-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1395916769-20475-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140328.161007.1937376826264802047.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu, 27 Mar 2014 11:39:29 +0100

> The mvneta driver currently uses of_iomap(), which has two drawbacks:
> it doesn't request the resource, and it isn't devm-style so some error
> handling is needed.
> 
> This commit switches to use devm_ioremap_resource() instead, which
> automatically requests the resource (so the I/O registers region shows
> up properly in /proc/iomem), and also is devm-style, which allows to
> get rid of some error handling to unmap the I/O registers region.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Does this actually fix any bugs?  It seems like the unmaps happen in
all the necessary cases.

If it's just a simplification or cleanup I'm going to apply this to
net-next.
