From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 08:21:31 +0100
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151125015137.GA11298@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <3811106.btnGdZynet@wuerfel> <20151125015137.GA11298@codeaurora.org>
Message-ID: <24402293.zXE5ex9jKn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 November 2015 17:51:37 Stephen Boyd wrote:
> On 11/24, Arnd Bergmann wrote:
> > On Monday 23 November 2015 15:13:52 Stephen Boyd wrote:
> > IOW, anything with CPU implementer 0x56 part 0x581 should use those,
> > while part 0x584 can use the sdiv/udiv that it reports correctly.
> > 
> 
> It looks like we have some sort of function that mostly does
> this, except it doesn't differentiate on that lower bit for 1 vs
> 4. I guess I'll write another one for that.
> 
> static inline int cpu_is_pj4(void)
> {
>         unsigned int id;
> 
>         id = read_cpuid_id();
>         if ((id & 0xff0fff00) == 0x560f5800)
>                 return 1;
> 
>         return 0;
> }

Correct, thanks.

	Arnd
