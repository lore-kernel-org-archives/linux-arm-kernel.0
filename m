From: zecke@selfish.org (Holger Freyther)
Date: Fri, 10 Jun 2011 20:47:18 +0200
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <alpine.LFD.2.02.1106061719290.13964@ionos>
References: <4DECCADE.6080100@selfish.org>
	<4DECD8C0.6010908@freyther.de>	<alpine.LFD.2.02.1106061650210.13964@ionos>	<4DECEDF9.4010202@selfish.org>
	<alpine.LFD.2.02.1106061719290.13964@ionos>
Message-ID: <4DF266B6.6090303@selfish.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2011 05:25 PM, Thomas Gleixner wrote:
> On Mon, 6 Jun 2011, Holger Freyther wrote:
>> On 06/06/2011 04:54 PM, Thomas Gleixner wrote:
>>
>> and both interrupts should be on REG1.. so for IRQ56 it looks like this method
>> is entered with bogus data. Again, I have no idea about the underlying code,
>> but could there be an issue with chained irq and the GC IRC code?
> 
> Crap, yes. The code which does the chained handler setup overwrites
> chip_data.


Hi Thomas,

I think the for loop above the one that was patched has the same kind of issue
(changing the irq_chip_data)? One needs to have a dm365.c for this code to
become active though.

In general what do you think about a patch like the one below, it is at least
boot tested on a qemu-system-i386.
