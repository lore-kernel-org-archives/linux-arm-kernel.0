From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 4 Apr 2016 11:20:00 +0530
Subject: dtc warnings
In-Reply-To: <20160404051656.GV17806@rob-hp-laptop>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
 <56FE27F9.2070100@gmail.com>
 <CAJKOXPdDyVbfSyshu4j21Ax2J-VwPpMZgAGEeO8VtgFYh4hTmw@mail.gmail.com>
 <56FE7E4A.2000601@ti.com> <20160403065909.GF2987@vireshk-i7>
 <20160403080854.GA12133@kozik-lap>
 <CAKohpomijKf3m07Lc3+fWawxAPwe83F8k9akz1LOTokpZNL2ig@mail.gmail.com>
 <20160404051656.GV17806@rob-hp-laptop>
Message-ID: <20160404055000.GA3622@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04-04-16, 00:16, Rob Herring wrote:
> On Sun, Apr 03, 2016 at 05:57:00PM +0530, Viresh Kumar wrote:
> > On 3 April 2016 at 13:38, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> > > Warnings coming from recent linux-next:
> > >
> > >   DTC     arch/arm/boot/dts/exynos5800-peach-pi.dtb
> > > Warning (unit_address_vs_reg): Node /opp_table0/opp at 1800000000 has a unit name, but no reg property
> > > Warning (unit_address_vs_reg): Node /opp_table0/opp at 1700000000 has a unit name, but no reg property

Something isn't right in my setup, as I am not hitting these:

$ make CROSS_COMPILE="arm-linux-gnueabihf-" ARCH=arm O=../bexynos dtbs
make[1]: Entering directory '/mnt/ssd/all/work/repos/devel/bexynos'
  CHK     include/config/kernel.release
  Using /mnt/ssd/all/work/repos/devel/linux as source for kernel
  GEN     ./Makefile
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
make[2]: 'include/generated/mach-types.h' is up to date.
  CHK     include/generated/bounds.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/asm-offsets.h
  CALL    /mnt/ssd/all/work/repos/devel/linux/scripts/checksyscalls.sh
<stdin>:1310:2: warning: #warning syscall preadv2 not implemented [-Wcpp]
<stdin>:1313:2: warning: #warning syscall pwritev2 not implemented [-Wcpp]
  DTC     arch/arm/boot/dts/exynos3250-artik5-eval.dtb
  DTC     arch/arm/boot/dts/exynos3250-monk.dtb
  DTC     arch/arm/boot/dts/exynos3250-rinato.dtb
  DTC     arch/arm/boot/dts/exynos4210-origen.dtb
  DTC     arch/arm/boot/dts/exynos4210-smdkv310.dtb
  DTC     arch/arm/boot/dts/exynos4210-trats.dtb
  DTC     arch/arm/boot/dts/exynos4210-universal_c210.dtb
  DTC     arch/arm/boot/dts/exynos4412-odroidu3.dtb
  DTC     arch/arm/boot/dts/exynos4412-odroidx.dtb
  DTC     arch/arm/boot/dts/exynos4412-odroidx2.dtb
  DTC     arch/arm/boot/dts/exynos4412-origen.dtb
  DTC     arch/arm/boot/dts/exynos4412-smdk4412.dtb
  DTC     arch/arm/boot/dts/exynos4412-tiny4412.dtb
  DTC     arch/arm/boot/dts/exynos4412-trats2.dtb
  DTC     arch/arm/boot/dts/exynos5250-arndale.dtb
  DTC     arch/arm/boot/dts/exynos5250-smdk5250.dtb
  DTC     arch/arm/boot/dts/exynos5250-snow.dtb
  DTC     arch/arm/boot/dts/exynos5250-snow-rev5.dtb
  DTC     arch/arm/boot/dts/exynos5250-spring.dtb
  DTC     arch/arm/boot/dts/exynos5260-xyref5260.dtb
  DTC     arch/arm/boot/dts/exynos5410-smdk5410.dtb
  DTC     arch/arm/boot/dts/exynos5420-arndale-octa.dtb
  DTC     arch/arm/boot/dts/exynos5420-peach-pit.dtb
  DTC     arch/arm/boot/dts/exynos5420-smdk5420.dtb
  DTC     arch/arm/boot/dts/exynos5422-odroidxu3.dtb
  DTC     arch/arm/boot/dts/exynos5422-odroidxu3-lite.dtb
  DTC     arch/arm/boot/dts/exynos5422-odroidxu4.dtb
  DTC     arch/arm/boot/dts/exynos5440-sd5v1.dtb
  DTC     arch/arm/boot/dts/exynos5440-ssdk5440.dtb
  DTC     arch/arm/boot/dts/exynos5800-peach-pi.dtb
make[1]: Leaving directory '/mnt/ssd/all/work/repos/devel/bexynos'

> > 
> > @Rob: What should we be doing about these warnings?
> > OPP-entries don't have a reg property obviously and we
> > discussed earlier if naming them based on freq is fine or
> > not.
> 
> We can whitelist opp nodes in dtc, use oppN instead, or ignore the 
> warnings for now. 

I will be required to update check_unit_address_vs_reg() for that, right ? Or
is there a easier way for doing this ? :)

-- 
viresh
