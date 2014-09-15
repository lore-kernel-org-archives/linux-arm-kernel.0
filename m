From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 15 Sep 2014 13:50:56 +0200
Subject: [PATCH 00/16 v9] omap 8250 based uart + DMA
In-Reply-To: <20140912224324.GK18849@atomide.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <20140912224324.GK18849@atomide.com>
Message-ID: <5416D2A0.5020407@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2014 12:43 AM, Tony Lindgren wrote:
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140910 12:30]:
>> the diff of v8?v9 is small:
>> - rebased on top's of Greg's tty-next branch
>> - fixed #10 where we might have THRE interrupt enabled for longer than
>>   needed
>> - re-did register setup in #10. Before this "less file" could freeze the
>>   am335x-evm.
> 
> FYI, looks like merging in your uart_v9 branch for testing
> with my hwmod changes now fails to produce RX characters on omap3.
> 
> The device wakes up just fine to the wake-up interrupt, and then
> serial8250_handle_irq() gets called, but I'm not seeing anything
> in the console getting printed out. It's like all the RX characters
> are getting lost instead of just the first one. The RX characters
> work fine when the system is running.
> 
> So it seems there's been some kind of regression since v8?

I changed the restore function the fix the am335x-evm + less "freeze".
And now we have this. So let me search?

> Regards,
> 
> Tony
> 

Sebastian
