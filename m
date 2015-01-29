From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 29 Jan 2015 17:51:32 +0000
Subject: randconfig bug: ARM/KVM link error in hyp_idmap section
In-Reply-To: <CAEDV+gKzkER4n=oNiM1wNmNnbMEosYKo=Awu8j8R5Fr7kzE_Ew@mail.gmail.com>
References: <3919069.MpPCrczKD2@wuerfel>	<CAEDV+gJ3YO8oeka_yaJGg+LXA0Od0TGkZb8vD_q74xNRx9g0Rg@mail.gmail.com>	<1611315.VFEsrxkfBf@wuerfel>	<54CA5954.8060506@arm.com>
 <CAEDV+gKzkER4n=oNiM1wNmNnbMEosYKo=Awu8j8R5Fr7kzE_Ew@mail.gmail.com>
Message-ID: <54CA7324.7000000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/01/15 17:40, Christoffer Dall wrote:
> 
> 
> On Thu, Jan 29, 2015 at 5:01 PM, Marc Zyngier <marc.zyngier@arm.com
> <mailto:marc.zyngier@arm.com>> wrote:
> 
>     Hi Arnd,
> 
>     On 29/01/15 15:53, Arnd Bergmann wrote:
>     > On Thursday 29 January 2015 16:23:42 Christoffer Dall wrote:
>     >> the changes look ok, but I don't understand why putting stuff in
>     rodata is
>     >> a good solution, is it simply by chance that the linker then
>     generates
>     >> fewer veneers there?  I think we're only branching internally in
>     the hyp
>     >> idmap text page anyhow, so wondering why this appears in the
>     first place...
>     >> hmmm.
>     >
>     > The linker will not generate any veneers for .rodata because it
>     does not
>     > expect executable code in there. As I said, above, this is also
>     correct
>     > because it matches how we access that section (read-only, never
>     execute).
> 
>     Not sure about the later point. We only copy the code if it is not page
>     aligned, and use it in place otherwise. I guess we could change that,
>     but we'd need the same change for arm64.
> 
> 
> I'd be ok with changing that... 

In which case I have no further objection.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
