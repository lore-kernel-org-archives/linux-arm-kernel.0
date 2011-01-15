From: christer@weinigel.se (Christer Weinigel)
Date: Sat, 15 Jan 2011 18:44:22 +0100
Subject: Locking in the clk API
In-Reply-To: <20110115172033.GM15996@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<4D2D184A.8020405@codeaurora.org>
	<20110112090301.GS11039@n2100.arm.linux.org.uk>
	<4D31A8F1.4080301@weinigel.se>
	<20110115145358.GC15996@n2100.arm.linux.org.uk>
	<4D31D45A.8080509@weinigel.se>
	<20110115172033.GM15996@n2100.arm.linux.org.uk>
Message-ID: <4D31DCF6.7090805@weinigel.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2011 06:20 PM, Russell King - ARM Linux wrote:
 > You really need to read the entire thread - I've already said that yet

> discussion continues about how to solve the problem.  This thread which
> has been running for a number of days now has been entirely about how
> to solve this.


Sigh, the always oh so polite Russell.  I have read the thread before; I 
reread the whole thread one more time before posting.

> Consider this: is it better to continue talking about this for the next
> six months, while still having N spinlock based implementations, and M
> mutex based implementations.
>
> Or is it better to consolidate the N spinlock based implementations
> down to one spinlock implementation, and M mutex based implementations
> down to one mutex implementation, and then discuss how to resolve the
> differences between the two implementations?


Going that way might very well mean that you will be stuck with two 
implementations forever.  But yes, it might be better with two working 
ones than one which takes a bit longer to finish.

But my impression is that the different suggestions in the thread aren't 
that far apart.  Except for the discussion if clk_enable/disable should 
be able to sleep or not, people seem to agree on most of the rest of the 
API.

   /Christer
