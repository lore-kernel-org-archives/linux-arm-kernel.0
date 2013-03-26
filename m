From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 21:43:23 +0000
Subject: [PATCH v2 05/10] arm: zynq: Move slcr initialization to separate
 file
In-Reply-To: <dc278dadd3614b4736f43a09b9c5d7ccd2232403.1364319776.git.michal.simek@xilinx.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <dc278dadd3614b4736f43a09b9c5d7ccd2232403.1364319776.git.michal.simek@xilinx.com>
Message-ID: <201303262143.23708.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Michal Simek wrote:
> Create separate slcr driver instead of pollute common code.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Can't you move that code into the zynq_cpu_clk_setup function
instead, and only call of_clk_init(NULL) from platform code?

I would like to eventually add a default call to of_clk_init(NULL)
for all platforms, and that would be a step in that direction.

	Arnd
