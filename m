From: andy@warmcat.com (Andy Green)
Date: Fri, 12 Mar 2010 09:33:37 +0000
Subject: bit errors on spitz
In-Reply-To: <1268384824.4963.35.camel@utx.utx.cz>
References: <20100305212708.GC21773@elf.ucw.cz>	
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>	
	<20100308072858.GA29939@atrey.karlin.mff.cuni.cz>	
	<20100308082530.GA1982@atrey.karlin.mff.cuni.cz>	
	<4B98EF5D.5000609@warmcat.com>
	<1268322155.3990.114.camel@hammer.suse.cz>	
	<4B995EE1.1050609@warmcat.com>
	<1268384824.4963.35.camel@utx.utx.cz>
Message-ID: <4B9A0A71.7010206@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/10 09:07, Somebody in the thread at some point said:

>> Unless there's more to it in the way the zaurus using it that regulator
>> isn't programmable digitally.
>
> OOPS, I made a mistake and linked ISL6721 instead of ISL6271 there.
> Now it is fixed:
> http://www.penguin.cz/~utx/zaurus/datasheets/power/XScale/ISL6271A.pdf
>
> This one has I2C. It is connected to GPIO 3 (PWR_SCL) and GPIO 4
> (PWR_SDA).

Thanks... that defaults to 1.3V on Vcore if you don't touch it.  I guess 
confirm on the CPU datasheet that it's OK for your selected CPU clock speed.

> I guess that Zaurus has a good power design and that voltage should be
> constant enough. CF has a dedicated step down (plus 2.8V power detector

In that case is the PXA CF driver PIO?  Then it can be the same load on 
Vcore issue in disguise.

-Andy
