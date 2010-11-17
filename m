From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 10:47:43 +0000
Subject: [PATCH v3 15/20] ARM: LPAE: use phys_addr_t instead of unsigned
	long for physical addresses
In-Reply-To: <20101116193335.GD21926@n2100.arm.linux.org.uk>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
	<1289842829-3027-16-git-send-email-catalin.marinas@arm.com>
	<4CE2D811.50701@codeaurora.org>
	<20101116193335.GD21926@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinDGk2HPg7py9nzsqmM3_AbSG_GJJYwsiMr+wQL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2010 19:33, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 16, 2010 at 11:14:25AM -0800, Stephen Boyd wrote:
>> On 11/15/2010 09:40 AM, Catalin Marinas wrote:
>> > @@ -188,21 +189,21 @@
>> > ? * translation for translating DMA addresses. ?Use the driver
>> > ? * DMA support - see dma-mapping.h.
>> > ? */
>> > -static inline unsigned long virt_to_phys(void *x)
>> > +static inline phys_addr_t virt_to_phys(void *x)
>> > ?{
>> > ? ? return __virt_to_phys((unsigned long)(x));
>> > ?}
>>
>> As you're already in the area can you mark the argument to
>> virt_to_phys() as const? I ran into a compiler warning due to that the
>> other day.
>
> It may make sense to mark it const volatile, as that's the most
> permissive set of attributes possible (iow, it'll accept any pointer
> without warning.) ?However, might be an idea to check what other
> arches do.

The majority of architectures use volatile and a few add both const
and volatile.

I usually use the generic headers as reference for function prototypes
and that's just using volatile without a const (cc'ing Arnd for any
view on this).

-- 
Catalin
