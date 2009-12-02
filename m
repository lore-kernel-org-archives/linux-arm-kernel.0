From: yeasah@comrex.com (Yeasah Pell)
Date: Wed, 02 Dec 2009 11:39:10 -0500
Subject: strange, spurious seeming vector exception on pxa300
In-Reply-To: <20091202160400.GE14091@buzzloop.caiaq.de>
References: <4B159524.2020408@comrex.com>	<f17812d70912012200m4532317eue21baf5e10925455@mail.gmail.com>	<f17812d70912012207x28178b1bh98fbf560b6da536@mail.gmail.com>	<4B167C69.6060903@comrex.com>	<20091202155057.GA30669@n2100.arm.linux.org.uk>
	<20091202160400.GE14091@buzzloop.caiaq.de>
Message-ID: <4B16982E.2000704@comrex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack wrote:
> On Wed, Dec 02, 2009 at 03:50:57PM +0000, Russell King - ARM Linux wrote:
>>
>>
>> Given that the conditions are clearly wrong for a vector exception, I would
>> say that you're hitting some kind of hardware bug - maybe caused by a dirty
>> power supply to the PXA, causing it to misbehave?
>>     

Of course I desperately want to believe this, as then I can ignore all 
this insanity and move on, but it's a bit difficult to swallow that some 
kind of hardware issue would cause a failure that is so consistent (same 
instruction every time, regardless of physical/virtual memory locations, 
compilation flags, etc.) yet caused absolutely no other perceptible 
problems...

> We've had trouble of that kind as well some month ago with an early
> prototype. It wasn't an exception we got, but the bug was clearly
> hitting the same code path every single time, so this issue might be
> related. Eventually it went away with new board revision which made wire
> patching around the DDR SDRAM unnecessary (i.e, cleaner signal pathes).
>
> Strange enough, I would have expected such flaws to cause processor
> misbeviour of all sorts, totally random and unpredictable. The fact that
> is was the same function we always ended up in is still some kind of
> miracle I can't explain.
>
> Daniel
>   

...and having some anecdotal evidence of that kind of situation 
happening is helpful.

Thanks, guys.
