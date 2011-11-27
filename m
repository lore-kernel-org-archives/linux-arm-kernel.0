From: mturquette@ti.com (Turquette, Mike)
Date: Sat, 26 Nov 2011 17:12:47 -0800
Subject: [PATCH v3 0/5] common clk framework
In-Reply-To: <20111126070601.GA19176@S2100-06.ap.freescale.net>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <20111126070601.GA19176@S2100-06.ap.freescale.net>
Message-ID: <CAJOA=zMGaXLrC=sLzrZKTqAKqQHpmn9=xx94ucaCsFAZ6EfYqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 11:06 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Mon, Nov 21, 2011 at 05:40:42PM -0800, Mike Turquette wrote:
>> ? .speaking of which, clk_set_rate has been overhauled and is now
>> recursive. *collective groan*. ?clk_set_rate is still simple for the
>> common case of simply setting a single clk's rate. ?But if your clk has
>> the CLK_PARENT_SET_RATE flag and the .round_rate callback recommends
>> changing the parent rate, then clk_set_rate will recurse upwards to the
>> parent and try it all over again. ?In the event of a failure everything
>> unwinds and all the clks go out for drinks.
>>
> I smell that this will be the part which makes the whole series risky
> of being accepted in a desired time frame, with saying rate change
> notifications are still missing for now.

I agree.  I'll send out V4 this coming week with the clk rate change
notifiers rolled in.  That means that there won't be any missing
pieces for my vision of how a complex clk tree should interact with
drivers.  If it is not what people want then we can probably de-scope
pieces of it, but I think the architecture is sound.

Thanks for reviewing Shawn.

Regards,
Mike
