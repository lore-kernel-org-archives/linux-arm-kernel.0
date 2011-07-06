From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 5 Jul 2011 19:42:13 -0600 (MDT)
Subject: [PATCH] OMAP: hwmod: add kernel cmdline flag to avoid resetting
	IP blocks during init
In-Reply-To: <20110704085503.GQ23145@atomide.com>
References: <20110703010204.19046.85186.stgit@dusk>
	<20110703010206.19046.85293.stgit@dusk>
	<20110704085503.GQ23145@atomide.com>
Message-ID: <alpine.DEB.2.00.1107051936250.4217@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc'ing Aaro

On Mon, 4 Jul 2011, Tony Lindgren wrote:

> Also related is the gptimer12 on secure omaps as reported by Aaro.

This problem is actually worse.  In this case it's not just preventing 
reset; we must prevent the kernel from using the device at all. My 
understanding is also that it's the X-Loader or bootloader -- or more 
broadly, secure mode code -- that actually chooses which devices are 
protected in this way.  In other words, we can't make any automatic 
decisions that are based on knowing that a chip is a high-security chip -- 
it will need to be defined by the board file :-(

For this case, we probably need some board file function to tell the hwmod 
code to disregard a device completely, to tell the kernel to pretend that 
the device does not exist.


- Paul
