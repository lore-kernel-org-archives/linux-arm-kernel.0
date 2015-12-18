From: alex.aring@gmail.com (Alexander Aring)
Date: Fri, 18 Dec 2015 11:55:21 +0100
Subject: [PATCH v2 0/8] Raspberry Pi 2 support.
In-Reply-To: <20151218100826.GB1145@omega>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <20151218100826.GB1145@omega>
Message-ID: <20151218105520.GA2764@omega>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 11:08:26AM +0100, Alexander Aring wrote:
> Hi Eric,
> 
> On Wed, Dec 16, 2015 at 03:55:07PM -0800, Eric Anholt wrote:
> > This is a major rewrite of the previous Raspberry Pi 2 submission.
> > SMP support is now included, and the DT includes are cleaned up to
> > avoid massive duplication.
> > 
> > The branch (based on 4.4-rc5, to get the USB regression fixes) can be
> > found at:
> > 
> > https://github.com/anholt/linux/tree/bcm2836-4.4
> > 
> 
> thanks. :-)
> 
> I tried it via booting with the RPi firmware and your branch, but it
> doesn't boot on my side:
> 
> I get:
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 4.4.0-rc5+ (alex at omega) (gcc version 4.9.2 (OSELAS.Toolchain-2014.12.1) ) #989 Fri Dec 18 10:54:40 CET 2015
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine model: Raspberry Pi 2 Model B Rev 1.1
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Truncating RAM at 0x00000000-0x3e000000 to -0x30000000
> [    0.000000] Consider using a HIGHMEM enabled kernel.
> [    0.000000] Memory policy: Data cache writeback
> [    0.000000] BUG: mapping for 0x3f201000 at 0xf0201000 out of vmalloc space
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm/kernel/devtree.c:149 arm_dt_init_cpu_maps+0x100/0x1a4()
> [    0.000000] DT /cpu 2 nodes greater than max cores 1, capping them
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.0-rc5+ #989
> [    0.000000] Hardware name: BCM2835

Because this, I thought I boot with the wrong devicetree. But then I saw
[0].

Can this not set to BCM2836 when I include "bcm2836.dtsi" and BCM2835,
when I include "bcm2835.dtsi"?

- Alex

https://github.com/anholt/linux/blob/bcm2836-4.4/arch/arm/boot/dts/bcm283x.dtsi#L12
