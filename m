From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Tue, 26 Apr 2016 20:53:37 +0530
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <571F2427.5030003@arm.com>
 <5485255.0LNbKf2a8b@wuerfel>
Message-ID: <20160426152337.GA10644@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 26, 2016 at 09:17:43AM +0100, Vladimir Murzin wrote:

> I built myself, but there are prebild tools available at [1] although
> I've never tried them.
> 
> It seems to me there have been internal patches to support FDPIC [2],
> but I don't know what happen afterwards :(
> 
> [1] https://launchpad.net/gcc-arm-embedded
> [2]
> http://connect.linaro.org/resource/sfo15/sfo15-406-arm-fdpic-toolset-kernel-libraries-for-cortex-m-cortex-r-mmuless-cores/

Thank You, [2] gave some indigestion :), will take some to ...

On Tue, Apr 26, 2016 at 01:59:57PM +0200, Arnd Bergmann wrote:
> On Tuesday 26 April 2016 11:57:38 Vladimir Murzin wrote:

> and there are probably use cases for ARMv7-A without MMU.

My regular work is motor control related that uses RTOS, there was a
potential customer asking about running it with MMU, caches disabled
on A9. Probably the reason being they considering guranteed worst
case performance w/ caches enabled similar to that w/ caches disabled,
though that requirement was not in Linux.

> > Right they are quite close and shares a lot of code except MMU and MPU,
> > and I'd think without MMU/MPU such configurations are limited with UP

> I think one problem is that with MMU disabled ARMv7-A, you implicitly
> disable the caches and that is probably what you are thinking of for
> SMP support as well (atomic instructions need caches).

Have once tried to compile ARMv7-A w/o MMU, got entangled in a web of
Kconfig dependencies, iirc one among them was that with !MMU, MULTI_V7
platforms (AM335x, Vybrid A5 part) couldn't be selected, probably
because of SMP dependency, but that was on a older Kernel version.

Regards
afzal
