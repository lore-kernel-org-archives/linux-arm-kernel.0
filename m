From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 5 Jul 2011 20:00:47 -0600 (MDT)
Subject: [PATCH] OMAP: hwmod: add kernel cmdline flag to avoid resetting
	IP blocks during init
In-Reply-To: <alpine.DEB.2.00.1107051936250.4217@utopia.booyaka.com>
References: <20110703010204.19046.85186.stgit@dusk>
	<20110703010206.19046.85293.stgit@dusk>
	<20110704085503.GQ23145@atomide.com>
	<alpine.DEB.2.00.1107051936250.4217@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1107051955450.4217@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Jul 2011, Paul Walmsley wrote:

> For this case, we probably need some board file function to tell the 
> hwmod code to disregard a device completely, to tell the kernel to 
> pretend that the device does not exist.

... and the other problem here is that we currently probe devices via an 
arch_initcall(), and the board file init_machine is also an arch_initcall.
Either we'll need to be very careful about Makefile ordering, or we should 
just call omap2_init_devices() from the board file init_machine directly.
The latter makes the most sense to me.


- Paul
