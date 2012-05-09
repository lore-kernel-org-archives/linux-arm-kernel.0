From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 14:19:50 +0000
Subject: [PATCH 1/2] mfd: max8925: request resource region
In-Reply-To: <20120509141316.GS3955@opensource.wolfsonmicro.com>
References: <1336360249-29963-1-git-send-email-haojian.zhuang@gmail.com>
 <201205091243.13206.arnd@arndb.de>
 <20120509141316.GS3955@opensource.wolfsonmicro.com>
Message-ID: <201205091419.50736.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Mark Brown wrote:
> It does result in the really odd situation that the number that gets
> stored in the resource is the register number plus an offset.  If
> anything I'd expect that the resources would be defined so you had to
> add the parent base address with the child resource being the offset
> within the parent resource.  Though to be honest the parent resource is
> almost always going to be numbered from zero so it's not going to make
> much difference most of the time.

But that's not how any of the other resources work: AFAICT, each resource
type makes up an address space with unique ranges assigned to each 
sibling and sub-ranges inside of that for its children.

	Arnd
