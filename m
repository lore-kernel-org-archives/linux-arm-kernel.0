From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 2 Jun 2011 17:39:19 +0900
Subject: [PATCH] ARM: exynos4: fix secondary CPU boot
In-Reply-To: <1307003689.31098.6.camel@e102391-lin.cambridge.arm.com>
References: <1305899190-16732-1-git-send-email-marc.zyngier@arm.com>
	<4DDD3C57.6020705@samsung.com>
	<1306346645.27474.182.camel@e102391-lin.cambridge.arm.com>
	<4DDD531A.50604@samsung.com>
	<1306422710.27474.237.camel@e102391-lin.cambridge.arm.com>
	<BANLkTi=fjq5ki8BGDhQxHVD3u-s7W-C1rw@mail.gmail.com>
	<1307003689.31098.6.camel@e102391-lin.cambridge.arm.com>
Message-ID: <BANLkTi=mvCgi_6Y57aVjpwrMhL58zPcUHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 2, 2011 at 5:34 PM, Marc Zyngier <Marc.Zyngier@arm.com> wrote:
> On Thu, 2011-06-02 at 16:01 +0900, Kyungmin Park wrote:
>> On Fri, May 27, 2011 at 12:11 AM, Marc Zyngier <Marc.Zyngier@arm.com> wrote:
>> > On Wed, 2011-05-25 at 12:06 -0700, Kukjin Kim wrote:
>> >> On 05/25/11 11:04, Marc Zyngier wrote:
>> >> > On Wed, 2011-05-25 at 10:28 -0700, Kukjin Kim wrote:
>> >> >> On 05/20/11 06:46, Marc Zyngier wrote:
>> >>
>> >> (snip)
>> >>
>> >> > So that address has changed between two SoC revisions? That's
>> >> > unfortunate, to say the least. I'm most probably using an early revision
>> >> > of the hardware (EVT0?), as it doesn't even support MCT.
>> >> >
>> >> I'm afraid :( and I agree secondary CPU should work on all of
>> >> Exynos4210. But I'm still think about the method...
>> >>
>> >> > What about the following patch?
>> >> >
>> >> Uhm...this is really hack but I'd like to use another normal way...?
>> >
>> > Oh, no question about the hack status. The trouble is, unless there is a
>> > sure way to tell which SoC revision we're running on, there's little
>> > else we can do than poke both locations and pray.
>> >
>> > Is there such a way to identify the SoC revision?
>>
>> It's also required for OneNAND. as you know C210 EVT0 OneNAND DMA has
>> bug and need to workaround.
>>
>> platform codes should provide the these function. please see the OMAP
>> codes. how to handle it.
>
> So we know there's a need beyond the wish to see the second core up and
> running on my board.
>
> Now what is the proper method to detect the revision of the SOC?
> Handling it is no problem, once we have the information. Unfortunately
> the documentation I have is less than helpful on that subject.

It can be distinguished by chip id. but there's no code to handle this one.

0x4320 0200 EVT0
0x4321 0210 EVT1
0x4321 0211 EVT2

Thank you,
Kyungmin Park
>
> Cheers,
>
> ? ? ? ?M.
> --
> Reality is an implementation detail.
>
>
>
