From: andy@warmcat.com (Andy Green)
Date: Thu, 11 Mar 2010 21:21:37 +0000
Subject: bit errors on spitz
In-Reply-To: <1268322155.3990.114.camel@hammer.suse.cz>
References: <20100305212708.GC21773@elf.ucw.cz>	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>	<4B98EF5D.5000609@warmcat.com>
	<1268322155.3990.114.camel@hammer.suse.cz>
Message-ID: <4B995EE1.1050609@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/10 15:42, Somebody in the thread at some point said:
> Andy Green wrote:
>
>> I saw very similar failures for a long time on our iMX31 based device.
>> Eventually I found a Freescale errata where the RAM inside the USB2
>> macrocell started to make single bit errors below 1.38V Vcore; ours was
>> 1.4V at that time but dipped on CPU load.
>
> Good tip. It seems that nobody ported driver for the voltage control
> chip ISL6271 from 2.4 kernel, and bootloader probably does not set
> correct values.
>
> Datasheet:
> http://www.penguin.cz/~utx/zaurus/datasheets/power/Xscale/ISL6271.pdf

Unless there's more to it in the way the zaurus using it that regulator 
isn't programmable digitally.

Reading about your CF Card WLAN related issues they suck down a good 
amount of power when their radio is up, I would definitely suggest 
monitoring with a 'scope the various rails (Vcore, RAM and whatever it 
is the CF Card is powered by) while putting it under load.

-Andy
