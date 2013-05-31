From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 17:04:17 +0200
Subject: [PATCH v2] dmaengine: shdma: fix a build failure on platforms
 with no DMA support
In-Reply-To: <51A8BB0D.9060907@ti.com>
References: <Pine.LNX.4.64.1305310423360.1470@axis700.grange>
 <alpine.DEB.2.00.1305311504460.6919@axis700.grange> <51A8BB0D.9060907@ti.com>
Message-ID: <4422231.HoYmB8LUsn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 May 2013 10:00:29 Dan Murphy wrote:
> My consideration was that since this is an exported symbol that a driver
> could call this API explicitly without checking for
> the function pointer first, there is a potential of calling a NULL pointer.

Drivers never call a filter function directly, so that is not an issue.
Even if a driver would try it, that would not actually compile.
	
	Arnd
