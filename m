From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 2 Apr 2011 03:59:02 +0100
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <alpine.LFD.2.00.1104011441150.28032@xanadu.home>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104011659.40443.arnd@arndb.de> <4D95EF8E.9080902@vollmann.ch>
	<201104011750.17344.arnd@arndb.de>
	<alpine.LFD.2.00.1104011441150.28032@xanadu.home>
Message-ID: <20110402025901.GB13341@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2011 at 03:54:47PM -0400, Nicolas Pitre wrote:

> 1) GPIO drivers

>    As Linus observed, in the majority of the cases GPIOs are accessed 
>    through simple memory-mapped registers.  Some have absolute state 
>    registers, the others have separate clear/set registers.  Suffice to 
>    create two generic GPIO drivers each covering those two common cases, 
>    and those generic drivers would simply register with the higher level 
>    gpiolib code, and all the board code would have to do is to provide 
>    the data for those GPIOs (register offsets, number of GPIOs, etc.).  
>    Whether this data eventually comes from DT is an orthogonal issue.

For this case we actually already have the basic_mmio_gpio driver in
tree, we should be pushing for wider usage of that.
