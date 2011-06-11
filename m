From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 11 Jun 2011 14:49:55 +0200
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <19955.20458.788309.51588@pilspetsen.it.uu.se>
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<20110601225826.GR3660@n2100.arm.linux.org.uk>
	<20110611051510.GA3283@riccoc20.at.omicron.at>
	<19955.20458.788309.51588@pilspetsen.it.uu.se>
Message-ID: <20110611124955.GA2983@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 11, 2011 at 01:22:18PM +0200, Mikael Pettersson wrote:
> Richard Cochran writes:
>  > I took another look at the whole MMIO clocksource implementation and
>  > can't understand why all of the accessors use le_to_cpu. This seems to
>  > imply that all peripheral buses are little endian (except for ixp,
>  > which no one cares about, anyhow).
> 
> "no one"? ixp4xx is still being used.

Yes, I know, but I was trying and failed to sound sacastic.

>  > I understand (or have been told) that almost all arm implementations
>  > out there are little endian. Why not use use a normal load to read the
>  > timer? Are there machines with LE peripheral buses but BE cores?
> 
> ARM cores often have software-controllable endianess (see the ARM ARM).
> Off the top of my head:
> - ixp4xx: natively BE core and peripherals, but some people like to
>   switch the core to LE for user-space SW compatibility reasons
>   (I run my ixp4xx in BE as intended though)
> - Kirkwood: natively LE core and peripherals, but the core is switchable
>   to BE, although driver support for that appears to be incomplete

So, would you say that using le_to_cpu in the MMIO clocksource reading
functions makes good sense, or not?

Thanks,
Richard
