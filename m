From: ian.molton@codethink.co.uk (Ian Molton)
Date: Mon, 30 Jul 2012 17:52:57 +0100
Subject: [PATCH 4/6] kirkwood: setup clock only in eth helpers.
In-Reply-To: <20120730161230.GM18016@lunn.ch>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-5-git-send-email-ian.molton@codethink.co.uk>
 <20120730161230.GM18016@lunn.ch>
Message-ID: <5016BBE9.40604@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/12 17:12, Andrew Lunn wrote:
> On Mon, Jul 30, 2012 at 04:15:57PM +0100, Ian Molton wrote:
>> This patch modifies the ethernet setup helper functions so that
>> they can be used /purely/ to set up the clocks.
>
> Hi Ian
>
> Set up is a bit ambiguous. I would actually say, start the clock
> ticking, if it is not already.

Fair.

> I'm also not sure this is the best way to do it. I'd like to throw
> in a counter proposal, and then we can discuss....
>
> Problems start then the ethernet driver is a module, not built in.

I find that even if built in, it fails, not because it forgets its MAC, but
later, it hangs because as yet it does not know how to handle the clk
when it is set up from DT bindings. (Kirkwood doesnt really have this
support yet AFAICT).

> I've not looked at the clk DT bindings yet. Does it provide a
> mechanism to prepare & enable a named clock? Maybe it does, but this
> seems a bit of an edge case.

If it does, I cant see it.

> What i would instead do is add code to board-dt.c which looks into
> the DT and see if it finds nodes egige0/egige1 and if so, calls
> clk_prepare_enable(). We then don't need any per board code.

I agree, this seems like a good compromise for now.

I will implement this for v2.

-Ian

-Ian
