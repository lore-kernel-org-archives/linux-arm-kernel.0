From: joel@jms.id.au (Joel Stanley)
Date: Thu, 28 Sep 2017 14:29:22 +1000
Subject: [PATCH v2 3/5] clk: aspeed: Add platform driver and register PLLs
In-Reply-To: <1506497645.30138.37.camel@aj.id.au>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-4-joel@jms.id.au>
 <1506343255.30138.29.camel@aj.id.au>
 <CACPK8Xd8RQ4s1xMsSuxHgQRiHS6vDtxVTAxu8Ba3J3it45MC5g@mail.gmail.com>
 <1506497645.30138.37.camel@aj.id.au>
Message-ID: <CACPK8XeJE025GRT9kk9L1x1VsDGEmLG80G9LMM03vsvpHS+sYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 5:34 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Wed, 2017-09-27 at 16:13 +1000, Joel Stanley wrote:
>> > > +                     div_table,
>> >
>> > This doesn't seem to be correct. There's the problem of 0b000 and 0b001 mapping
>> > the same value of 2 for the AST2500, whose table then increments in steps of 1.
>> > The AST2400 mapping on the otherhand is multiples of 2 starting at 2, with no
>> > inconsistency for 0b000 vs 0b001.
>>
>> Yep, we do use a different table for ast2400 vs ast2500. See
>> ast2400_div_table vs ast2500_div_table.
>
> Yep, but for the AST2500 this is a different table again to what you've
> already defined (for the AST2500). However, for the AST2400 the table
> looks the same as the other AST2400 tables.

You're right. I didn't realise you were pointing out something strange
about eclk.

I added another table for eclk, and the correct one is selected by the
platform data.

I'll send out v4 today if no more reviews come in.
