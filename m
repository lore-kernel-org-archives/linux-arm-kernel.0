From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 8 Nov 2011 11:33:25 -0700
Subject: [RFC] clocktree representation in the devicetree
In-Reply-To: <20111018071618.GI18141@pengutronix.de>
References: <20111017102921.GA18141@pengutronix.de>
 <4E9C5F71.5070608@gmail.com>
 <20111017184358.GD18141@pengutronix.de> <4E9CB63C.1000200@gmail.com>
 <20111018071618.GI18141@pengutronix.de>
Message-ID: <CACxGe6u9MHithb3Zkdy58tXFME9u8QEOseP2oEKvsx_Y-TagBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 1:16 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Mon, Oct 17, 2011 at 06:11:56PM -0500, Rob Herring wrote:
>> Good point. I guess the board specifics can go all the way back up the
>> clock tree.
>>
>> It's good to see a real example. but it would be nice to see some
>> documentation to update this:
>>
>> http://www.devicetree.org/ClockBindings
>>
>> Do you have any code using this? I've updated the OF clock support based
>> on Mike's latest common clk code that I need to send out. But it's based
>> on the above clock binding.
>
> I wasn't aware of this page. As I see it I could rewrite my suggestion
> so that it extends these clock bindings without really changing them.
> I have no code working yet, I first wanted to see how the reactions are.

Some working code that implements that proposal already exists in my
devicetree/test branch, but I'm not very happy with the binding (even
though I wrote it).  I'm uncomfortable about mixing phandle and string
values in the same property since it isn't a common device tree idiom.
 Rob and I talked about this at Connect last week, and I actually sat
down to rework the binding an patches to something that I'm happier
with.  I'll post the patches as an RFC later today.

A big thing for me is I don't want to require a separate node for each
and every clock source.  In some cases the clock complex can be
considered to be a single block for the whole SoC, particularly when
the internal interconnects are never visible to device drivers.  In a
case like that I don't want to force the DT writer to explode the
whole think out into nodes when there isn't a benefit to doing so.

Also, the rewritten binding is designed to follow the pattern already
established somewhat by the interrupts and gpio binding where the clk
tree is completely independent of the natural DT structure so that
arbitrary complex mappings can be described easily.

Cheers,
g.
