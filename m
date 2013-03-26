From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 21:46:58 +0000
Subject: [PATCH v2 10/10] arm: zynq: Add cpuidle support
In-Reply-To: <3395757de41837ecc1d84aac1a06ebcc23fe1367.1364319776.git.michal.simek@xilinx.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <3395757de41837ecc1d84aac1a06ebcc23fe1367.1364319776.git.michal.simek@xilinx.com>
Message-ID: <201303262146.58590.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Michal Simek wrote:
> Add support for cpuidle.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> v2: Fix file header
> ---
>  arch/arm/mach-zynq/Makefile  |    1 +
>  arch/arm/mach-zynq/cpuidle.c |  133 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
>  create mode 100644 arch/arm/mach-zynq/cpuidle.c

Can you move that file to drivers/cpuidle instead?

>+/* Initialize CPU idle by registering the idle states */
>+static int xilinx_init_cpuidle(void)
>+{
>+       unsigned int cpu;
>+       struct cpuidle_device *device;
>+       int ret;
>+
>+       ret = cpuidle_register_driver(&xilinx_idle_driver);
>+       if (ret) {
>+               pr_err("Registering Xilinx CpuIdle Driver failed.\n");
>+               return ret;
>+       }

I think you have to check that you actually run on a Zynq system before
registering the driver.

	Arnd
