From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 9 Jul 2012 18:56:46 +0530
Subject: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <20120709132501.GJ1122@atomide.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com> <20120709131156.GH1122@atomide.com>
 <20120709132501.GJ1122@atomide.com>
Message-ID: <CAMQu2gyfh6+3KopeQFNFhKWdqJGK_AR=An19kKxt6n7Fv9iOUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2012 at 6:55 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [120709 06:17]:
>> * Vaibhav Hiremath <hvaibhav@ti.com> [120709 01:55]:
>> > On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
>> > > --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
>> > > +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
>> > > @@ -39,6 +39,7 @@ struct omap_clk {
>> > >  #define CK_443X          (1 << 11)
>> > >  #define CK_TI816X        (1 << 12)
>> > >  #define CK_446X          (1 << 13)
>> > > +#define CK_54XX          (1 << 14)
>> >
>> > This is conflicting with AM33XX, you may want to rebase it again, since
>> > AM33xx clock tree is already pushed and available in
>> > linux-omap/devel-am33xx-part2.
>>
>> Heh these CK_XXXX defines are now running out of the u16 cpu_mask.
>>
>> They really should be replaced with SoC specific lists of clocks
>> rather than bloating the cpu_mask and repeating it for every clock
>> that's compiled in for 800+ times.
>>
>> Below (untested) is what could be done in the short term.
>>
>> I wonder if we could #define CK_OMAP_DUMMY 0 that's always set
>> for non-shared clocks if they only get set in some *_data.c
>> file in a unique way?
>>
>> Paul got any better ideas?
>
> Santosh, I suggest you just drop the CK_54XX change from your patches
> as the clock fwk support will need further patching and is not used
> yet.
>
Good idea. Will have a look at it.

Regards
Santosh
