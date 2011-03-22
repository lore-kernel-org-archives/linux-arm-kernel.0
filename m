From: ratbert.chuang@gmail.com (Po-Yu Chuang)
Date: Tue, 22 Mar 2011 10:40:23 +0800
Subject: [PATCH v2] arm: cmpxchg syscall should data abort if page not
	write
In-Reply-To: <alpine.LFD.2.00.1103211639470.11889@xanadu.home>
References: <1300098516-1601-1-git-send-email-ratbert.chuang@gmail.com>
	<1300169637-1628-1-git-send-email-ratbert.chuang@gmail.com>
	<alpine.LFD.2.00.1103171301030.26889@xanadu.home>
	<AANLkTik1oEkLX3R-adK9-_2W+ku4j9YDikr+Z4vzfGtb@mail.gmail.com>
	<alpine.LFD.2.00.1103171344270.26889@xanadu.home>
	<AANLkTi=Zq0fiVf+GcRC8M+CPakwmEWn1rrqq_U4OehNy@mail.gmail.com>
	<alpine.LFD.2.00.1103211639470.11889@xanadu.home>
Message-ID: <AANLkTimESa1haKLtS6YmJwK3r=R0=gV4C_eOxSCs0dfa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Nicolas Pitre,

On Tue, Mar 22, 2011 at 4:41 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 18 Mar 2011, Po-Yu Chuang wrote:
>> On Fri, Mar 18, 2011 at 1:57 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > Nope. ?The code being fixed here was suptly broken so it needs fixing.
>> > However this code is almost never used, if at all, as it is a fall-back
>> > solution for when all the better alternatives are not available for some
>> > reasons (and I'm still wondering what those reasons are for Po-Yu Chuang
>> > to actually use that code). ?In practice this bug should have affected
>> > no one.
>>
>> We met this problem while porting an v5 SMP processor because kernel
>> selects NEEDS_SYSCALL_FOR_CMPXCHG by default if CPU_32v5.
>>
>> After we added our own implementation of __kuser_cmpxchg, this code
>> is not needed anymore. But since this is actually a bug, it is still a good
>> idea to submit a patch. :-)
>
> Yes. ?Please send to RMK's patch system with my ACK.

I thought that Russell King would apply this patch after you ACKed it.
Doesn't it work like this here? How should I do next?

Best regards,
Po-Yu Chuang
