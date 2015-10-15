From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 15 Oct 2015 10:40:45 +0800
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <20151015101920.7fa592f7@canb.auug.org.au>
References: <20151015101920.7fa592f7@canb.auug.org.au>
Message-ID: <20151015104045.04136253@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

On Thu, 15 Oct 2015 10:19:20 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the arm-soc tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arch/arm/boot/dts/berlin2q.dtsi:62.24-25 syntax error
> FATAL ERROR: Unable to parse input tree

I just checked, this is caused by missing the following two commits

f72d787d9287 ("clk: berlin: move MAX_CLKS out of drivers/clk/berlin")

44b2e5f96d5e ("clk: berlin: add cpuclk")

Thanks,
Jisheng

> 
> I can't see what caused this error, so I have just used the arm-soc tree
> from next-20151013 for today.
> 
