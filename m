From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Apr 2012 08:47:46 +0100
Subject: [PATCH V3 1/8] CLKDEV: Add helper routines to allocate and add
 clkdevs for given struct clk *
In-Reply-To: <0fb69ddb87f9a5e6a6afec2f833c6341e45763c7.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <0fb69ddb87f9a5e6a6afec2f833c6341e45763c7.1335249846.git.viresh.kumar@st.com>
Message-ID: <20120426074746.GD24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 12:20:29PM +0530, Viresh Kumar wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> With common clock framework, clks are allocated at runtime. Some of them require
> clkdevs to be allocated and added in global clkdev list.
> 
> This patch introduces helper routines to:
> 
>  - allocate and add single clkdev for a single clk structure.
>  - add multiple clkdevs for a single clk structure.

This still causes additional warnings.  Having managed to get the build
for various platforms down to zero warnings, we now have:

drivers/clk/clkdev.c: In function 'clkdev_alloc':
drivers/clk/clkdev.c:209: warning: 'ap' may be used uninitialized in this function
drivers/clk/clkdev.c: In function 'clk_register_clkdev':
drivers/clk/clkdev.c:251: warning: 'ap' may be used uninitialized in this function

for everything building clkdev.c

I'll be dropping the patch.  Please fix.
