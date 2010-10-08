From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 07 Oct 2010 21:12:03 -0400 (EDT)
Subject: [PATCH 1/3] [ARM] Translate delay.S into (mostly) C
In-Reply-To: <4CAE619A.2050302@codeaurora.org>
References: <1285644827-6846-1-git-send-email-sboyd@codeaurora.org>
	<1285644827-6846-2-git-send-email-sboyd@codeaurora.org>
	<1286299355.18791.11.camel@c-dwalke-linux.qualcomm.com>
	<4CABEECB.4030301@codeaurora.org>
	<alpine.LFD.2.00.1010061024220.3107@xanadu.home>
	<4CACC053.2090509@codeaurora.org> <1286393743.22265.129.camel@m0nster>
	<alpine.LFD.2.00.1010061553350.3107@xanadu.home>
	<4CAE619A.2050302@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1010072107560.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Oct 2010, Stephen Boyd wrote:

> Why doesn't any other architecture use assembly for their lpj code? They
> may use headers with assembly in them or C code with assembly in them,
> but they don't write all of the delay code in assembly and rely on
> function interleaving. This leads me to believe other arches aren't
> concerned about compiler optimizations breaking lpj cmdline parameters,
> so why should ARM be concerned?
> 
> I tested the theory out and scaled down the CPU frequency to 19.2 MHz
> and then called calibrate_delay(). Before and after applying this series
> I got the same results.
> 
> Calibrating delay loop... 12.67 BogoMIPS (lpj=63360)
> 
> Jumping up to 1.2 GHz and calling calibrate_delay() gives me the same
> before and after
> 
> Calibrating delay loop... 792.98 BogoMIPS (lpj=3964928)

OK, fair enough.

> I don't have access to a machine capable of running slower than 19.2
> MHz. Maybe machines running in the KHz range would experience differences?

Don't worry, I doubt any ARM processor capable of running Linux ever was 
that slow.


Nicolas
