From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 May 2016 23:01:06 +0200
Subject: [PATCH 01/23] all: syscall wrappers: add documentation
In-Reply-To: <20160525.135039.244098606649448826.davem@davemloft.net>
References: <20160525200327.GA22395@yury-N73SV> <6293194.tGy03QJ9ME@wuerfel>
 <20160525.135039.244098606649448826.davem@davemloft.net>
Message-ID: <6407614.fdv5XFSBue@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 25, 2016 1:50:39 PM CEST David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 25 May 2016 22:47:33 +0200
> 
> > If we use the normal calling conventions, we could remove these overrides
> > along with the respective special-case handling in glibc. None of them
> > look particularly performance-sensitive, but I could be wrong there.
> 
> You could set the lowest bit in the system call entry pointer to indicate
> the upper-half clears should be elided.

Right, but that would introduce an extra conditional branch in the syscall
hotpath, and likely eliminate the gains from passing the loff_t arguments
in a single register instead of a pair.

	Arnd
