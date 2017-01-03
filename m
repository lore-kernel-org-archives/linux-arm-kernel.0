From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 3 Jan 2017 14:09:16 -0800
Subject: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
In-Reply-To: <21511994.eBlbEPoKOz@wuerfel>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
 <3492795.xaneWtGxgW@wuerfel>
 <CALCETrUCdu3kTBU09gXaSppO7VCm+872zkGnovaZKTXBbY2wTg@mail.gmail.com>
 <21511994.eBlbEPoKOz@wuerfel>
Message-ID: <CALCETrXmdAnbgjsxw=qTbP2PhVCzE8v3y5XMt8DVa4P9DowsGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 3, 2017 at 2:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, January 3, 2017 10:29:33 AM CET Andy Lutomirski wrote:
>>
>> Hmm.  What if we approached this a bit differently?  We could add a
>> single new personality bit ADDR_LIMIT_EXPLICIT.  Setting this bit
>> cause PER_LINUX32_3GB etc to be automatically cleared.
>
> Both the ADDR_LIMIT_32BIT and ADDR_LIMIT_3GB flags I guess?

Yes.

>
>> When
>> ADDR_LIMIT_EXPLICIT is in effect, prctl can set a 64-bit numeric
>> limit.  If ADDR_LIMIT_EXPLICIT is cleared, the prctl value stops being
>> settable and reading it via prctl returns whatever is implied by the
>> other personality bits.
>
> I don't see anything wrong with it, but I'm a bit confused now
> what this would be good for, compared to using just prctl.
>
> Is this about setuid clearing the personality but not the prctl,
> or something else?

It's to avid ambiguity as to what happens if you set ADDR_LIMIT_32BIT
and use the prctl.  ISTM it would be nice for the semantics to be
fully defined in all cases.

--Andy
