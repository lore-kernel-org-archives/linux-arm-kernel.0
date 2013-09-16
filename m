From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 16 Sep 2013 10:25:15 +0100
Subject: Vexpress config
In-Reply-To: <CAHSGOus7VsJh+-mpxOWeeyqfsB4jNYiG-vwRirFaJh39c3Heww@mail.gmail.com>
References: <CAHSGOuusvazUFFAAraCZmQgXr8LvwdV4zess=KsEMsCtbg0y2A@mail.gmail.com>
 <CAHSGOus7VsJh+-mpxOWeeyqfsB4jNYiG-vwRirFaJh39c3Heww@mail.gmail.com>
Message-ID: <1379323515.3998.12.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-09-15 at 14:40 +0100, melwyn lobo wrote:
> To better clarify the issue. When I boot a single core Cortex-A9 RTSM
> with vexpress_defconfig compiled kernel and kernel command line as
> 1.  "earlyprintk console=ttyAMA0,38400n8 mem=512M maxcpus=1"
> 2.  "earlyprintk console=ttyAMA0,38400n8 mem=512M maxcpus=0"
> 3.  "earlyprintk console=ttyAMA0,38400n8 mem=512M nosmp"
> 4.  "earlyprintk console=ttyAMA0,38400n8 mem=512M"
> the kernel throws an OOPS error:
> 
> Uncompressing Linux... done, booting the kernel.
> 
> Booting Linux on physical CPU 0x0
> Initializing cgroup subsys cpuset
> Linux version 3.10.9 (m.lobo at mcbdhost-Dataserver) (gcc version 4.7.3
> (Sourcery CodeBench Lite 2013.05-24) ) #8 Fri Sep 13 10:43:53 KST 2013
> CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine: ARM-Versatile Express

The Cortex-A9 RTSM is not an equivalent of the V2P-CA9 CoreTile, so you
have to boot your kernel with a relevant Device Tree. You'll find them
here: http://linux-arm.org/git?p=arm-dts.git;a=tree;f=fast_models

Now, the question is how do you actually boot the kernel? Can you cope
with the DTB? Linaro's boot wrapper
https://git.linaro.org/gitweb?p=arm/models/boot-wrapper.git can handle
DTBs, however you'll need some extra patches to get it working on A9.
Contact its maintainer (peter.maydel at linaro.org) if you were planning to
use it.

Good luck!

Pawel
