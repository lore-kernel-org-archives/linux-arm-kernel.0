From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Oct 2010 22:22:18 +0200
Subject: iwmmxt signal frame handling
In-Reply-To: <alpine.LFD.2.00.1010151426030.2764@xanadu.home>
References: <201010141609.10889.arnd@arndb.de>
	<201010151540.07982.arnd@arndb.de>
	<alpine.LFD.2.00.1010151426030.2764@xanadu.home>
Message-ID: <201010152222.18649.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 October 2010 20:38:15 Nicolas Pitre wrote:
> Hard to confirm.  The only way not to have TIF_USING_IWMMXT set is to 
> use old pre-EABI binaries, which are relying on the kernel emulated FPA 
> instructions for floating point, and nothing in those days might have 
> cared about extensions to the ucontext layout at all, or even have used 
> iwmmxt.  While this is a correctness fix, in practice this never 
> mattered.

Ok, good to know.
 
> And we're talking about mixed ABI environments which existed many years 
> ago, like prior the Git era.  Hardly a stable tree candidate.

Yes, that's pretty clear then. I had assumed the TIF flag meant that
a particular process had been using IWMMXT, not that it was allowed
to do them.

Thanks for the explanation,

	Arnd
