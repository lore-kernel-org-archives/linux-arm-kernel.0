From: lbassel@codeaurora.org (Larry Bassel)
Date: Thu, 16 Jun 2011 10:01:33 -0700
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <201106160006.07742.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<000901cc2b37$4c21f030$e465d090$%szyprowski@samsung.com>
	<20110615213958.GB28032@labbmf-linux.qualcomm.com>
	<201106160006.07742.arnd@arndb.de>
Message-ID: <20110616170133.GC28032@labbmf-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 Jun 11 00:06, Arnd Bergmann wrote:
> On Wednesday 15 June 2011 23:39:58 Larry Bassel wrote:
> > On 15 Jun 11 10:36, Marek Szyprowski wrote:
> > > On Tuesday, June 14, 2011 10:42 PM Arnd Bergmann wrote:
> > > 
> > > > On Tuesday 14 June 2011 20:58:25 Zach Pfeffer wrote:
> > > > > I've seen this split bank allocation in Qualcomm and TI SoCs, with
> > > > > Samsung, that makes 3 major SoC vendors (I would be surprised if
> > > > > Nvidia didn't also need to do this) - so I think some configurable
> > > > > method to control allocations is necessarily. The chips can't do
> > > > > decode without it (and by can't do I mean 1080P and higher decode is
> > > > > not functionally useful). Far from special, this would appear to be
> > > > > the default.
> > 
> > We at Qualcomm have some platforms that have memory of different
> > performance characteristics, some drivers will need a way of
> > specifying that they need fast memory for an allocation (and would prefer
> > an error if it is not available rather than a fallback to slower
> > memory). It would also be bad if allocators who don't need fast
> > memory got it "accidentally", depriving those who really need it.
> 
> Can you describe how the memory areas differ specifically?
> Is there one that is always faster but very small, or are there
> just specific circumstances under which some memory is faster than
> another?

One is always faster, but very small (generally 2-10% the size
of "normal" memory).

Larry

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
