From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 1 Nov 2011 10:32:22 +0100
Subject: [PATCH] AMBA: Use suspend_noriq to force devices into runtime
	suspend
In-Reply-To: <Pine.LNX.4.44L0.1110281051090.2175-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1110281051090.2175-100000@iolanthe.rowland.org>
Message-ID: <4EAFBCA6.4020105@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Stern wrote:
> On Fri, 28 Oct 2011, Ulf Hansson wrote:
> 
>> The idea with having them as separate functions and something with 
>> "runtime" in the name is because it is only when having 
>> CONFIG_PM_RUNTIME the functions actually does something.
> 
> No, that's off the main point.
> 
> In fact, you're not really using these terms properly.  You shouldn't 
> think of "runtime suspend" as a single verb -- that is, you shouldn't 
> think "Okay, let's runtime-suspend this device now".
> 
> The verb is just "suspend", and it means the same thing as "put into a
> low-power state".  The "runtime" part refers to _when_ the low-power 
> transition takes place: while the rest of the system is running (as 
> opposed to while the rest of the system is going to sleep).
> 
> Thus, it makes no sense at all for a comment in a suspend_noirq
> callback to say "let's runtime-suspend the device".  That's a 
> contradiction in terms.  The right way to think about it is more like 
> this: "If the device isn't already in a low-power state, let's put it 
> in a low-power state now".
> 
> In your case, the device already is (or should be) at low power.  A
> better way to phrase this might be: "If the device's power hasn't
> already been turned off, and the device doesn't need to generate wakeup
> requests, turn off the power now".
> 
> Alan Stern
> 
> 

Ok, thanks for input! I will clarify my comments and commit message and 
send a v3 patch (although the heading of the v3 patch will be changed to 
not including something with "runtime" suspend).

BR
Ulf Hansson
