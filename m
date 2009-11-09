From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Mon, 9 Nov 2009 10:06:15 +0100
Subject: orion/kirkwood pcie issue still open with rc6
In-Reply-To: <20091109094958.4ba72970@marrow.netinsight.se>
References: <200911090933.46240.dk-arm-linux@gmx.de>
	<20091109094958.4ba72970@marrow.netinsight.se>
Message-ID: <200911091006.15757.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag 09 November 2009 09:49:58 schrieb Simon Kagstrom:
> On Mon, 9 Nov 2009 09:33:46 +0100
> Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> 
> > Ronan Shitrit from marvell gave me the information to clear bit 2 of physical
> > address 0xf1020100 to enable bus scanning.
> > I don't know what this really does but it helped to get my kernel up and running.
> 
> You have that in the functional specification for the kirkwood
> processors:
> 
>   http://www.marvell.com/files/products/embedded_processors/kirkwood/FS_88F6180_9x_6281_OpenSource.pdf
> 
> See Appendix A for the register set and lookup address 0x20100 (the CPU
> configuration register). Bit 2 in that register turns on/off error
> propagation:
> 
>               Mbus-L Error propogation
>               For a list of errors see "Error Handling".
>               0 = NoErrProp: Error indications are not propagated to Mbus-L. The
>                   transactions are completed normally.
>               1 = ErrProp: Error indications are propagated to Mbus-L.
> 
> and clearing it sounds quite a bit like hiding the real problem :-).
> 

I've seen this and you're absolutely right. Thats why I've posted!

> 
> Probably it's best to try to find out what's causing this error (see
> the Error Handling section of the PCIe chapter in the reference manual
> above) so that that a proper fix can be implemented!

And here my problems are starting ;)
How can I implement error handling for that kind of reported errors?
I'm sorry but I've absolutely no idea.

> 
> // Simon

Many thanks,
Dieter
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
