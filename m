From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 Dec 2014 18:31:13 +0000
Subject: using DMA-API on ARM
In-Reply-To: <20141205182443.GX11285@n2100.arm.linux.org.uk>
References: <5481794E.4050406@broadcom.com> <4565667.WCBuNmaazQ@wuerfel>
 <20141205111114.GQ11285@n2100.arm.linux.org.uk>
 <20141205173839.GB31222@e104818-lin.cambridge.arm.com>
 <20141205182443.GX11285@n2100.arm.linux.org.uk>
Message-ID: <20141205183113.GD31222@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 05, 2014 at 06:24:43PM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 05, 2014 at 05:38:39PM +0000, Catalin Marinas wrote:
> > On Fri, Dec 05, 2014 at 11:11:14AM +0000, Russell King - ARM Linux wrote:
> > > In any case, wouldn't using a u64 type for "address" be better - isn't
> > > "long long" 128-bit on 64-bit architectures?
> > 
> > No, it's still 64-bit. There is no 128-bit integer in the C standard.
> 
> Actually, that's a fallicy.
> 
> The C99 standard (like previous versions) does not define exactly the
> number of bits in each type.  It defines ranks of type, and says that
> lower ranks are a subrange of integers with higher ranks (for the same
> signed-ness.)  See section 6.2.5.
> 
> So, it merely states that:
> 
> range(char) <= range(short) <= range(int) <= range(long) <= range(long long)

You are probably right, I haven't checked. But the ABI we use in Linux
for 64-bit, LP64, defines long long as 64-bit. Gcc has a int128_t type
but it's specific to this toolchain.

-- 
Catalin
