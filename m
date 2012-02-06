From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 6 Feb 2012 16:29:26 +0000
Subject: [RFC] ARM hugetlb support
In-Reply-To: <4F2B3B3E.6080807@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <CAHkRjk6xZy3Nsy=R05664RM0Sw071rkXmV2g9ySwqiS_BrBLrw@mail.gmail.com>
 <4F289BE2.9020404@gmail.com>
 <CAHkRjk49uGqFpdUZu0hYbHx3jHO9e0qv6OFN-NpwZPg-nnzfcQ@mail.gmail.com>
 <4F2B3B3E.6080807@gmail.com>
Message-ID: <20120206162926.GH26538@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 01:41:18AM +0000, bill4carson wrote:
> On 2012?02?02? 22:38, Catalin Marinas wrote:
> > On 1 February 2012 01:56, bill4carson<bill4carson@gmail.com>  wrote:
> >> On 2012?01?31? 17:29, Catalin Marinas wrote:
> >>> It also doesn't
> >>> help much with the TLB hit rate since the micro-TLB most likely only
> >>> support 1MB sections.
> >> I am afraid I can't agree with you on this.
> >> Truly there is no specific statement about whether micro-TLB support 16MB
> >> super-sections,
> >> but main-TLB actually helps the hit rate, and main-TLB support all page size
> >> mapping.
> > The feedback over time was that 16MB didn't help much in terms of TLB
> > misses compared to 1MB but that was for standard usage. I guess the
> > hugetlbfs has specific scenarios that may benefit.
> >
> > Anyway, could you make the 2MB/16MB huge page size configurable at
> > boot time (command line option like on other architectures)?
> Actually, only X86 supports multiple page size configuration at boot 
> time, other architectures will has fixed huge page size once build.

Boot time would be just fine on ARM as well. But as we go towards single
zImage, the super-sections may not be always available so one can always
use sections as a fall-back.

> I'm not sure it's a MUST to support multiple page size at boot time,
> but I'm sure this will make marco "pte_pfn" much more complicated.

I'm not entirely sure the complicated pte_pfn is needed (see my other
comment).

-- 
Catalin
