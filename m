From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 16:32:42 +0200
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <20141002113742.2b521495@canb.auug.org.au>
References: <20141002113742.2b521495@canb.auug.org.au>
Message-ID: <14357384.nIoLZkacVq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 October 2014 11:37:42 Stephen Rothwell wrote:
> After merging the arm-soc tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arch/arm/boot/dts/exynos5250-snow.dts:13:46: fatal error: dt-bindings/clock/maxim,max77686.h: No such file or directory
>  #include <dt-bindings/clock/maxim,max77686.h>
>                                               ^
> 
> Caused by commit c04c92ed5614 ("ARM: dts: Add rtc_src clk for s3c-rtc
> on exynos5250-snow").
> 
> Presumably there is some dependency on some tree that someone has
> forgotten to merge 
> 
> I reverted that commit for today.
> 
> Which then got to:
> 
> /scratch/sfr/next/arch/arm/boot/dts/exynos5420-peach-pit.dts:15:46: fatal error: dt-bindings/clock/maxim,max77802.h: No such file or directory
>  #include <dt-bindings/clock/maxim,max77802.h>
>                                               ^
> compilation terminated.
> /scratch/sfr/next/arch/arm/boot/dts/exynos5800-peach-pi.dts:15:46: fatal error: dt-bindings/clock/maxim,max77802.h: No such file or directory
>  #include <dt-bindings/clock/maxim,max77802.h>
>                                               ^
> compilation terminated.
> Error: /scratch/sfr/next/arch/arm/boot/dts/hisi-x5hd2.dtsi:417.21-22 syntax error
> FATAL ERROR: Unable to parse input tree
> 
> Caused by 8bd43b6e6df7 ("ARM: dts: Add rtc_src clk for s3c-rtc on
> exynos Peach boards").
> 
> I give up ... please test your trees better ...

I'm deeply sorry about that. I actually saw the problem here but was too
tired to fix it up again by redoing all the merges in our next/late
branch.

I've changed the for-next branch now to drop all of next/late, I think
we're better off not sending any of it for 3.18, especially as I found
some other problems as well.

> I have used the arm-soc tree form next-20141001 for today (which still
> needs 5 reverts to get it to build :-().

D'oh. I actually fixed these already last friday in the next/dt branch
but for some reason forgot to include it in for-next.
I've made sure that everything is included now.

	Arnd
