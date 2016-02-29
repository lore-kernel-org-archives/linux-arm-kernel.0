From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 29 Feb 2016 22:11:19 +0100
Subject: [PATCH 2/2] clk: bcm2835: expose current divider,
 parent and mash via debugfs
In-Reply-To: <87h9gr5jt3.fsf@eliezer.anholt.net>
References: <1456755616-2472-1-git-send-email-kernel@martin.sperl.org>
 <1456755616-2472-3-git-send-email-kernel@martin.sperl.org>
 <87h9gr5jt3.fsf@eliezer.anholt.net>
Message-ID: <058897BC-1090-4171-B239-D2A289F1D626@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 29.02.2016, at 21:43, Eric Anholt <eric@anholt.net> wrote:
> 
> kernel at martin.sperl.org writes:
> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> For each clock expose the following values via debugfs:
>> * current_parent - the currently selected parent
>> * current_divi - the integer portion of the currently set divider
>> * current_divf - the fractional portion of the currently set divider
>> * current_frac - the current frac/mash settings for the divider
> 
> current_parent can already be found through /debug/clk/clk_summary quite
> nicely I think.  If we wanted a per-clock parent file, that seems like
> something the core ought to be doing.
> 
> current_frac is looking at a bit that doesn't exist for non-MASH clocks.
> 
> divi/divf are OK, I guess, but don't seem particularly useful given the
> raw register output already.  A cooked floating point point divider
> debugfs entry would be nice, but I don't know if we can do that.

The reason I had those is because I wanted to allow people to
see quickly what is the parent clock and what is the used 
parent and divider?

While discussing with the PCM/I2s people they were always concerned
about those details - so I needed to provide them with a way to access
those things easily. And explaining to them the register format was -
for me - out of the question.

Especially the mapping of ?id? to real parent was a bit of a pain.

What do you mean by cooked? Something like: "33+27/4096??

Martin
