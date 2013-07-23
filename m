From: monstr@monstr.eu (Michal Simek)
Date: Tue, 23 Jul 2013 14:31:22 +0200
Subject: [PATCH 0/5] ARM: DT: remove redundant DT related code
In-Reply-To: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <51EE779A.8000205@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2013 01:32 PM, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Hi,
> 
> As part of my changes to remove duplicate code for parsing cpu nodes
> in the device tree, I found few unnecessary code mostly around smp_init_cpus.
> Most of the ARM Cortex A9 based platforms use SCU to get the number of cpus
> while many others depend on the device tree.
> 
> Even on DT based platforms using SCU, they can be made to depend on DT
> to cpu count simplifying smp_init_cpus. In fact arm_dt_init_cpu_maps called
> before smp_init_cpus, already does the device tree parsing, validating
> nr_cpu_ids and setting the cpu_possible_mask appropriately. 
> 
> However this series targets only the platforms using DT for cpu count
> (i.e. not using SCU)

Just a note. Zynq is using SCU to get cpu count not DT.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/4d2280f8/attachment.sig>
