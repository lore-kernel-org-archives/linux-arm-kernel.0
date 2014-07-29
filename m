From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 18:24:02 +0200
Subject: [PATCH 1/3] arm64: spin-table: handle unmapped cpu-release-addrs
In-Reply-To: <20140729161852.GC32108@leverpostej>
References: <1406630950-32432-1-git-send-email-ard.biesheuvel@linaro.org>
 <11934363.ljlrQOGpcO@wuerfel> <20140729161852.GC32108@leverpostej>
Message-ID: <2849588.TpFoAMfcUF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 17:18:52 Mark Rutland wrote:
> Sorry, I'd misunderstood the problem and my suggestion was nonsense
> deriving from that.
> 
> Having the (__force void *) cast in the call to __flush_dcache_area
> sounds like the right solution to me.

Well, there isn't really a good solution here I think, because you
are not really dealing with an iomem pointer after all, just something
a bit like that, but we don't have a 'memremap' function to do what
you really mean.

	Arnd
