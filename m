From: hechtb@gmail.com (Bastian Hecht)
Date: Wed, 6 Mar 2013 17:33:56 +0100
Subject: [PATCH v6 1/3] serial: sh-sci: Add OF support
In-Reply-To: <20130306152857.GJ14275@linux-sh.org>
References: <1362569437-11133-1-git-send-email-hechtb+renesas@gmail.com>
 <9335181.JoypQftkI4@avalon> <2479902.R2JaqaE7dT@avalon>
 <20130306152857.GJ14275@linux-sh.org>
Message-ID: <CABYn4sz6FHU50AhzN7jP781+ua8_JuZQASqCKZfddb4PerJoqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

2013/3/6 Paul Mundt <lethal@linux-sh.org>:
> On Wed, Mar 06, 2013 at 01:25:16PM +0100, Laurent Pinchart wrote:
>> On Wednesday 06 March 2013 13:10:55 Laurent Pinchart wrote:
>> > On Wednesday 06 March 2013 12:30:35 Bastian Hecht wrote:
>> > > +- renesas,scbrr-algorithm : Choose an algorithm ID for the baud rate
>> > > generator.
>> > > +  1 = SCBRR_ALGO_1 ((clk + 16 * bps) / (16 * bps) - 1)
>> > > +  2 = SCBRR_ALGO_2 ((clk + 16 * bps) / (32 * bps) - 1)
>> > > +  3 = SCBRR_ALGO_3 (((clk * 2) + 16 * bps) / (16 * bps) - 1)
>> > > +  4 = SCBRR_ALGO_4 (((clk * 2) + 16 * bps) / (32 * bps) - 1)
>> > > +  5 = SCBRR_ALGO_5 (((clk * 1000 / 32) / bps) - 1)
>> >
>> > Isn't it a property specific to our implementation of the driver instead of
>> > a hardware property ? How is one supposed to select the right algorithm ?
>>
>> I realize I haven't expressed myself very clearly here. What I mean is that
>> expressing how the baud rate generator works internally using an algorithm ID
>> is pretty specific to the Linux driver.
>>
>> I assume that, for a given serial port on a given SoC, the algorithm that
>> matches the baud rate generator hardware implementation needs to be selected.
>> Can't this information be inferred from the compatible string and port number
>> ?
>>
> Now that we have split things out in to regtype for the compat string we
> may be able to get away with selecting defaults that match the regtype
> and drop it from the binding (assuming all future parts remain relatively
> sane), but it would still complicate things if we were to ever do DT
> support for legacy CPUs. It's not enough to tie to the port type, as
> there are plenty of cases where the port type uses a non-standard algo on
> some CPU subtypes (although things are pretty consistent for the arm side
> so far).

regarding Laurent's question about the SCSCR register, do you think we
can assume the same there?
If so we could start out omitting these 2 properties and rely on
adding optional properties later in case we want to support legacy
stuff.
I don't see where it complicates things as we probably got the minimal
binding set then.

Thanks,

 Bastian
