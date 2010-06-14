From: wmb@firmworks.com (Mitch Bradley)
Date: Mon, 14 Jun 2010 08:20:47 -1000
Subject: Request review of device tree documentation
In-Reply-To: <alpine.LFD.2.00.1006141311580.13427@xanadu.home>
References: <4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org>
	<4C165FD1.6080505@firmworks.com>
	<alpine.LFD.2.00.1006141311580.13427@xanadu.home>
Message-ID: <4C1672FF.3060407@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> On Mon, 14 Jun 2010, Mitch Bradley wrote:
>
>   
>> First, the primary use case for "keeping OFW alive" is for debugging purposes.
>> OFW remains resident in memory so that, if the OS is set to allow it (not the
>> default), a hot-key freezes the OS and enters OFW, where a human can inspect
>> the state of devices and OS data structures. A high skill level is required,
>> so it's okay if some fiddling is necessary to find or establish virtual
>> addresses or do similar magic .  
>>     
>
> Why would you impose such pain on yourself in order to try to make OFW a 
> viable debugging tool on ARM for live kernels, while you can achieve the 
> same and more much less intrusively and so much more safely with a JTAG 
> based debugger?
>
> If the cost of a JTAG solution is a concern, you can order USB based 
> JTAG dongles on the net for less than $30 and use them with OpenOCD[1].
>   

If OFW is present on the machine, when a customer reports a problem I 
can tell them
to do x and y and z and tell me what they see.  In this manner, I have 
often solved
difficult problems in minutes or hours.

Arranging for a JTAG dongle to appear at the customer site, then getting 
it set up and
the necessary software installed and configured on a suitable host 
system, typically
requires several days at best, plus potentially a lot of fiddling 
depending on what
sort of host system the customer happens to have.

The phrase "impose such pain on yourself" presupposes that the technical 
challenges
are much harder than they actually are.  In fact, most of the pain comes 
from dealing
with the "yuck, why would you ever want to do that" argument.  I first 
experienced
that argument in 1982, when Tom Lyon - Sun's Unix driver expert at the 
time - threatened
to "scratch my disk" if I ported Forth to the Sun 1 machine.  Tom later 
recanted and
said that he was very glad that I had done so, after I used it to solve 
several stop-ship
problems that came close to killing the company.

> Otherwise, what's wrong with already supported kgdb, or even kdb?
>
> [1] http://openocd.berlios.de/web/
>   

Requires setup.  The power of "it's just there, flip a switch to turn it 
on" has to be
experienced in the heat of battle to be appreciated.

The other difference is that conventional debuggers focus on the problem of
inspecting and controlling the execution of preexisting programs, instead of
on the problem of constructing quick tests to test hypotheses.  While it is
possible to use them to "poke around", it quickly becomes cumbersome if you
need to do anything more complicated than just looking.  OFW's built-in
programming language is particularly well suited for making little test 
loops
on-the-fly.   Also, OFW has drivers for most of all of the system's 
hardware, and
those drivers are independently developed from the Linux drivers.  That 
often
serves as a valuable "second opinion" to help discover the root cause of 
hardware
misbehavior.
>
> Nicolas
>
>   
