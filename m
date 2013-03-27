From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 08:56:28 +0100
Subject: [PATCH v2 10/10] arm: zynq: Add cpuidle support
In-Reply-To: <201303262146.58590.arnd@arndb.de>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <3395757de41837ecc1d84aac1a06ebcc23fe1367.1364319776.git.michal.simek@xilinx.com>
 <201303262146.58590.arnd@arndb.de>
Message-ID: <CAHTX3d+ZHxiTSL38cyRXUz1Q4+GybbVwn7Ls9R=_Z2ozR6YwoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/26 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 26 March 2013, Michal Simek wrote:
>> Add support for cpuidle.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>> v2: Fix file header
>> ---
>>  arch/arm/mach-zynq/Makefile  |    1 +
>>  arch/arm/mach-zynq/cpuidle.c |  133 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 134 insertions(+)
>>  create mode 100644 arch/arm/mach-zynq/cpuidle.c
>
> Can you move that file to drivers/cpuidle instead?

I can't see any problem in it right now.

>>+/* Initialize CPU idle by registering the idle states */
>>+static int xilinx_init_cpuidle(void)
>>+{
>>+       unsigned int cpu;
>>+       struct cpuidle_device *device;
>>+       int ret;
>>+
>>+       ret = cpuidle_register_driver(&xilinx_idle_driver);
>>+       if (ret) {
>>+               pr_err("Registering Xilinx CpuIdle Driver failed.\n");
>>+               return ret;
>>+       }
>
> I think you have to check that you actually run on a Zynq system before
> registering the driver.

Is there any elegant way how to do it?
I see that Rob is checking compatible machine with of_machine_is_compatible().

Thanks,
Michal



-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
