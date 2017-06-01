From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu, 1 Jun 2017 19:37:26 +0300
Subject: how can KAsan support arm32?
In-Reply-To: <ba9fb499-98c5-4cfe-b68e-48a8df8d4ca9@googlegroups.com>
References: <d202a49e-ee0f-4864-b24b-b185255c7f11@googlegroups.com>
 <CACT4Y+aEW+CNH40mwY_i-mzL3cRYHc8EdMyhQj6dAiS+=0TpXg@mail.gmail.com>
 <20170601112424.GA8718@leverpostej>
 <CACT4Y+b5OiNrQqK-A2qHquZo266eXykWROLP=qj_BW__S2Wi5w@mail.gmail.com>
 <ba9fb499-98c5-4cfe-b68e-48a8df8d4ca9@googlegroups.com>
Message-ID: <e7d99272-bff0-59b9-f4ca-8b4482ef9bf4@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/01/2017 06:12 PM, ??? wrote:
> 
> ? 2017?6?1???? UTC+8??9:25:19?dvyukov???
> 
>     On Thu, Jun 1, 2017 at 1:24 PM, Mark Rutland <mark.r...@arm.com <javascript:>> wrote:
>     > Hi,
>     >
>     > Apologies for the delay in replying.
>     >
>     > On Tue, May 23, 2017 at 06:10:39AM +0200, Dmitry Vyukov wrote:
>     >> On Tue, May 23, 2017 at 5:48 AM,  <ifq...@gmail.com <javascript:>> wrote:
>     >> > hello everyone,
>     >> >
>     >> > I have a project use arm32 platform. Recently, lots of kernel memory
>     >> > corruption issues come out.
>     >> > I found KAsan might be useful, but can't run it on arm32.
>     >> > Is there any patch for arm32? I'm not familiar with memory debug, could
>     >> > someone give me a hint?
>     >>
>     >> Hello,
>     >>
>     >> There are no patches for arm32 as far as I know.
>     >>
>     >> Not sure if there is a 512MB free region for shadow, but we could use
>     >> the approach we used in the first kasan version: place shadow right in
>     >> physical memory, use outline instrumentation, outline instrumentation
>     >> does bounds check on address and accesses shadow only if address is
>     >> within physical memory.
>     >
>     > Would it be possible to raise this on the linux-arm-kernel mailing list?
>     >
>     > I think there are a few people interested in this, but most aren't
>     > watching thie kasan-dev mailing list.
> 
>     FTR, Andrey mentioned that he had a prototype arm32 support:
>     https://groups.google.com/d/msg/kasan-dev/JKYk2uUBriY/J6voOi7iAgAJ <https://groups.google.com/d/msg/kasan-dev/JKYk2uUBriY/J6voOi7iAgAJ>
> 
> 
> my system only have 256MB memory, and only have 70MB free memory after boot up.  Can this patch work on my board?
>  

kasan needs at least 1/8 of the total memory, so it will be 32MB in your case.
Plus some memory needed for slub redzones, increased stack size, but I can't tell you the exact number,
so you'll have to try.
