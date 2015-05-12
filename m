From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 12 May 2015 08:50:48 +0200
Subject: [PATCH] ARM: zynq: Set bit 22 in PL310 AuxCtrl register (6395/1)
In-Reply-To: <55519E47.7040008@de.bosch.com>
References: <812979c5a158a3306d8036e7f9731947c58a3ab7.1431411716.git.michal.simek@xilinx.com>
 <55519E47.7040008@de.bosch.com>
Message-ID: <5551A2C8.1070803@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2015 08:31 AM, Dirk Behme wrote:
> On 12.05.2015 08:22, Michal Simek wrote:
>> From: Thomas Betker <thomas.betker@rohde-schwarz.com>
>>
>> This patch is based on the
>> commit 1a8e41cd672f ("ARM: 6395/1: VExpress: Set bit 22 in the PL310
>> (cache controller) AuxCtlr register")
> 
> 
> I've been under the impression that this shouldn't be done in the
> kernel, but in the boot loader/firmware:
> 
> https://lkml.org/lkml/2015/2/20/199
> 
> http://lists.denx.de/pipermail/u-boot/2015-March/207803.html

Tegra, Exynos, sti still have this bit set.
Does that mean that they should be just removed because fix should be in
bootloader?

Anyway it is normal that bootloader stay on system untouched and only OS
is updated. But OK - let's make this in bootloader if this is preferred
solution.

Thanks,
Michal
