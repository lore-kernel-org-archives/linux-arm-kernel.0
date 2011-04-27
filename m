From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2011 15:16:30 +0200
Subject: [PATCH v4 01/11] mfd: add pruss mfd driver.
In-Reply-To: <1303474109-6212-2-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-2-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <201104271516.30951.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 April 2011, Subhasish Ghosh wrote:
> This patch adds the pruss MFD driver and associated include files.
> For details regarding the PRUSS please refer the folowing link:
> http://processors.wiki.ti.com/index.php/Programmable_Realtime_Unit_Subsystem
> 
> The rational behind the MFD driver being the fact that multiple devices can
> be implemented on the cores independently. This is determined by the nature
> of the program which is loaded into the PRU's instruction memory.
> A device may be de-initialized and another loaded or two different devices
> can be run simultaneously on the two cores.
> It's also possible, as in our case, to implement a single device on both
> the PRU's resulting in improved load sharing.
> 
> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>

Hi Subhasish,

This looks like great progress since the last time I looked at the
pruss mfd driver, good work there!

Thanks to your explanations and the documentation link, I now have
a better understanding of what is actually going on here, but I'd
still like to understandhow the decision is made regarding what programs
are loaded into each PRU and how the MFD cells are set up.

Is this a fixed setting for each board that strictly depends on how
the external pins are connected, or is it possible to use the same
hardware for different purposes based on the program?

If I read your code correctly, you hardwire the usage of the two
PRUs in the da850 board code, which makes it impossible to use
them in different ways even if the hardware supports it. If this is
indeed the case, using an MFD device might not be the best option
and we should try to come up with a way to dynamically repurpose
the PRU with some user interface.

	Arnd
