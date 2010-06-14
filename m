From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 Jun 2010 13:26:13 -0400 (EDT)
Subject: Request review of device tree documentation
In-Reply-To: <4C165FD1.6080505@firmworks.com>
References: <4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop> <1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com> <1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org> <4C165FD1.6080505@firmworks.com>
Message-ID: <alpine.LFD.2.00.1006141311580.13427@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jun 2010, Mitch Bradley wrote:

> First, the primary use case for "keeping OFW alive" is for debugging purposes.
> OFW remains resident in memory so that, if the OS is set to allow it (not the
> default), a hot-key freezes the OS and enters OFW, where a human can inspect
> the state of devices and OS data structures. A high skill level is required,
> so it's okay if some fiddling is necessary to find or establish virtual
> addresses or do similar magic .  

Why would you impose such pain on yourself in order to try to make OFW a 
viable debugging tool on ARM for live kernels, while you can achieve the 
same and more much less intrusively and so much more safely with a JTAG 
based debugger?

If the cost of a JTAG solution is a concern, you can order USB based 
JTAG dongles on the net for less than $30 and use them with OpenOCD[1].

Otherwise, what's wrong with already supported kgdb, or even kdb?

[1] http://openocd.berlios.de/web/


Nicolas
