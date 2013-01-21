From: nm@ti.com (Nishanth Menon)
Date: Mon, 21 Jan 2013 10:45:10 -0600
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <50FD6D8D.6030106@mimc.co.uk>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk>
Message-ID: <20130121164510.GA18905@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:32-20130121, Mark Jackson wrote:
> Vaibhav / Matt
> 
> On 20/01/13 21:38, Paul Walmsley wrote:
[...]
> 
> > Failing tests: needing local investigation (may be due to testbed issues)
> > -------------------------------------------------------------------------
> > 
> > Boot tests:
> > 
> > * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
> >   - May be fixed now, pending retest:
> >     - http://marc.info/?l=linux-omap&m=135082257727502&w=2
> >   - Not yet part of the automated test suite
> >   - Nishanth Menon & Vaibhav Hiremath report that it works for them
> >   * May be due to an old U-boot with FDT support problems used here?
> >     Pending local investigation and re-test
> 
> Does anyone know when the BeagleBone support is going to be fixed in mainline ?
> 
> I've just tried the latest linux-next git, and no joy.
> 
> However, Matt's edma-dmaengine-am33xx-v5 branch on github seems to be working:-
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.8.0-rc3-61978-g108da76-dirty (mpfj at mpfj-nanobone) (gcc version 4.5.4
> (Buildroot 2012.11-git-00497-ge48bf89) ) #7 SMP Mon Jan 21 15:52:14 GMT 2013
> [    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine: Generic AM33XX (Flattened Device Tree), model: TI AM335x BeagleBone
> 
> Are we just waiting for Matt's DMA stuff to be accepted ?
> 
for MMC filesystem - we need the edma series. for a ramdisk, I am able
to boot up to shell with 3.8-rc4 tag
see: http://pastebin.com/bGNxJnZJ
build configuration:
compiler:
$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
Copyright (C) 2011 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

U-boot:
git://git.denx.de/u-boot.git v2013.01-rc3
config: am335x_evm_config
kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v3.8-rc4
config: omap2plus_defconfig

-- 
Regards,
Nishanth Menon
