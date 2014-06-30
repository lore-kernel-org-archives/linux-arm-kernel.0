From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 30 Jun 2014 20:38:49 +0200
Subject: [PATCH 0/4] Migrate PXA27x platforms to clock framework
In-Reply-To: <7034630.fvV46PN35C@wuerfel> (Arnd Bergmann's message of "Mon, 30
 Jun 2014 08:55:15 +0200")
References: <1404066744-13416-1-git-send-email-robert.jarzmik@free.fr>
 <7034630.fvV46PN35C@wuerfel>
Message-ID: <877g3yp7ie.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Sunday 29 June 2014 20:32:20 Robert Jarzmik wrote:
>> As the RFC posted in [1] didn't meet an unrivaled success for
>> review, I'm posting this serie for PXA27x transition to clock
>> framework.
>> 
>> This transition is needed :
>>  - to enable device-tree drivers port, as clocks are needed almost
>>    everywhere
>>  - to enable the long term multi-platform kernel to support PXA
>> 
>> As I had said before, this serie aims at :
>>  - keeping legacy platforms working (ie. without device-tree)
>>  - enable PXA27x to work with a device-tree kernel, and hence
>>    open the way to drivers conversion
>>  - be robust enough to support pxa25x and pxa3xx later inclusion
>>    with almost no change to clk-pxa-dt.c.
>> 
>> As this serie is holding the rest of the device-tree drivers
>> port, I'd like it to be reviewed, even it's an old unsexy
>> platform.
>
> I have one basic question about this series: if pxa27x gets moved
> to used the common-clk framework but the others (pxa25x, pxa26x,
> pxa3xx, pxa93x) don't, does that imply that they become mutually
> exclusiv at compile-time?

Unfortunately yes, they become exclusive.
The reason being that arch/arm/mach-pxa/clock.c defines the function
"clk_enable()", which of course is also defined by the clock framework.

> If so, do you plan to first complete all of them before merging
> upstream, or do you intend to have one or more kernel releases
> that don't allow building a combined kernel for all pxa platforms?
I intend to have first only pxa27x.
Then in a second stage pxa27x + pxa25x + pxa3xx.

> I don't object to doing the latter, but if that is the plan, you
> need to make that very clear in the changelog and have all the
> relevant maintainers agree to that.
OK, that would be Haojian then, I think he maintains all PXA platforms.

Haojian, are you ok with that ? And BTW, does a combined kernel for PXA
platforms even exists (mixing pxa3xx and pxa2xx for example) ?

> Also (for my understanding) when you say that you plan to do
> pxa25x and pxa3xx next, does that include pxa26x and pxa93x?
I don't have the Technical Reference Manuals for these ones so the answer is
no. And Google wasn't a great friend at providing them.

> I assume it does as they are apparently minor revisions of the
> former, but it's not completely clear from your description.
My description doesn't mention them, as I have no information about them, nor
any hardware to test on.

Cheers.

-- 
Robert
