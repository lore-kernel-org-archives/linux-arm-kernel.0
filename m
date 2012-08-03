From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Aug 2012 16:43:55 +0100
Subject: MMAP_MIN_ADDR problem/question
In-Reply-To: <201208020939.50225.marek.vasut@gmail.com>
References: <201208020939.50225.marek.vasut@gmail.com>
Message-ID: <20120803154355.GA6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2012 at 09:39:50AM +0200, Marek Vasut wrote:
> Hi guys,
> 
> Me and a coleague of mine recently ran into the issue [1]. The problem is, that 
> I set mmap_min_addr to 65536, making it unable for "su - user" command to work, 
> it crashes with SIGKILL. I now at least see a solution (set it to 32768). Though 
> I don't understand why. Can someone please exaplain me why it has to be 32768 an 
> not more?
> 
> [1] http://ubuntu.5.n6.nabble.com/PATCH-DEFAULT-MMAP-MIN-ADDR-32768-for-arm-
> td1604723.html

Looks to me like there's a reading exercise for someone in the MXS
community who set the default to 64K.  The default in the Kconfig is
already appropriately chosen, so for the defconfig to have the 64K
value, someone must have _intentionally_ changed it without thinking
about what they were doing.

Just produce a patch to fix the defconfig.
