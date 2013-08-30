From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Aug 2013 15:22:11 +0100
Subject: [PATCH] ARM64: KVM: Fix =?UTF-8?Q?coherent=5Ficache=5Fguest?=
 =?UTF-8?Q?=5Fpage=28=29=20for=20host=20with=20external=20L=33-cache=2E?=
In-Reply-To: <20130830140446.GA14125@darko.cambridge.arm.com>
References: <20130815165344.GA3853@cbox>
 <CAAhSdy0mMAkziHQOYBw1yT1-h2N6vpQQdn_f25BEJpv2qYOHxA@mail.gmail.com>
 <CAAhSdy3W+q4yk992ajnHBb23SVDqmfe_4BiGfH9XTYkwfVmC-A@mail.gmail.com>
 <20130816171912.GB20246@cbox>
 <CAAhSdy2bk6Ou=326cYJW2wKvm9pffbRRmO2ABFwF9dmqwWdKqQ@mail.gmail.com>
 <20130816175034.GE20246@cbox>
 <CAAhSdy3B5JTcd7==u_QzS3V5k7pYkymtiLa7X=yZH+=eSBAw8w@mail.gmail.com>
 <20130830095215.GC62188@MacBook-Pro.local>
 <CAAhSdy0Hm1k+mWGGxUOzAA=5yVGNOERfo=36jcE1cvkUM=xtVg@mail.gmail.com>
 <bc23926cb9f202d8b63d729c584af791@www.loen.fr>
 <20130830140446.GA14125@darko.cambridge.arm.com>
Message-ID: <ac8cf7fa4f4bced56856c58ef335d7a9@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-08-30 15:04, Catalin Marinas wrote:
> On Fri, Aug 30, 2013 at 02:21:57PM +0100, Marc Zyngier wrote:
>> On 2013-08-30 11:44, Anup Patel wrote:
>> > For KVM, we can avoid flushing d-cache to PoC every time in
>> > coherent_icache_guest_page() by only doing it when Guest MMU is
>> > turned-off. This may reduce the performance penalty.
>>
>> What about the I and C bits in SCTLR_EL1? Does L3 also honour these
>> bits?
>
> I would think so, it probably cares about how the transactions are
> presented at the bus level by the CPU.

That'd make sense indeed. So we need to track both SCTLR_EL1.{I,C,M} in 
order to find out whether or not we need to clean the cache.

Mumble mumble...

         M.
-- 
Fast, cheap, reliable. Pick two.
