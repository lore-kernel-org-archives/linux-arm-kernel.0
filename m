From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Oct 2014 14:43:22 +0100
Subject: [PATCH] arm: fix flush_pfn_alias
In-Reply-To: <2144086.KBLsLT82pe@wuerfel>
References: <1413809642-12931-1-git-send-email-js07.lee@gmail.com>
 <2144086.KBLsLT82pe@wuerfel>
Message-ID: <20141020134322.GA20046@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 02:39:44PM +0100, Arnd Bergmann wrote:
> On Monday 20 October 2014 21:54:02 Jungseung Lee wrote:
> > L1_CACHE_BYTES could be larger than real L1 cache line size.
> > In that case, flush_pfn_alias function would omit to flush last bytes
> > as much as L1_CACHE_BYTES - real cache line size.
> 
> Can you list an example on what CPU this would happen in the
> patch description? Isn't the L1 cache line size always 32 bytes on ARM?

It's 64 bytes on A15, but I suspect it's always 32 bytes for this codepath
(VIPT aliasing D-side).

Will
