From: will.deacon@arm.com (Will Deacon)
Date: Thu, 9 Jun 2011 11:06:38 +0100
Subject: [PATCH 4/6] ARM: reset: add reset functionality for jumping to
	a physical address
In-Reply-To: <alpine.DEB.2.00.1106091053340.11513@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106071223100.2247@localhost6.localdomain6>
	<20110607132220.GB12639@e102144-lin.cambridge.arm.com>
	<alpine.DEB.2.00.1106071435020.2247@localhost6.localdomain6>
	<20110607153654.GA19855@arm.com>
	<alpine.DEB.2.00.1106071714400.2236@localhost6.localdomain6>
	<alpine.DEB.2.00.1106081638420.11513@localhost6.localdomain6>
	<20110608160527.GA6851@e102144-lin.cambridge.arm.com>
	<alpine.DEB.2.00.1106081707040.11513@localhost6.localdomain6>
	<20110608162429.GA28436@arm.com>
	<alpine.DEB.2.00.1106091053340.11513@localhost6.localdomain6>
Message-ID: <20110609100638.GC24873@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On Thu, Jun 09, 2011 at 11:00:56AM +0100, Frank Hofmann wrote:
> Ah, I was concerned that it'd change
> 
>  	graphics_cpu_reset ===> graphics_processor.reset
> 
> but you're correct that kind of substitution is not happening.
> 
> Anyway as Will mentioned, the !MULTI_CPU case has the #define the 
> following way in any case:
> 
> #define	____glue(name,fn)	name##fn
> #define	__glue(name,fn)		____glue(name,fn)
> #define	cpu_reset		__glue(CPU_NAME,_reset)
> 
> I.e. in the !MULTI_CPU case cpu_reset is defined without the macro 
> argument, while the MULTI_CPU define _has_ the macro argument.
> 
> Would it be ok to remove the (args) part from the MULTI_CPU #define then ?

I was planning to do that in v2 of the patches.

Cheers,

Will
