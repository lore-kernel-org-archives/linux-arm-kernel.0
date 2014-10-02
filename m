From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 02 Oct 2014 11:36:05 +0900
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <20141002113742.2b521495@canb.auug.org.au>
References: <20141002113742.2b521495@canb.auug.org.au>
Message-ID: <019c01cfdde9$9eb22ff0$dc168fd0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Mike

Stephen Rothwell wrote:
> 
> Hi all,
> 
Hi,

> After merging the arm-soc tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arch/arm/boot/dts/exynos5250-snow.dts:13:46: fatal error: dt-bindings/clock/maxim,max77686.h: No such
> file or directory
>  #include <dt-bindings/clock/maxim,max77686.h>
>                                               ^
> 
> Caused by commit c04c92ed5614 ("ARM: dts: Add rtc_src clk for s3c-rtc
> on exynos5250-snow").
> 
> Presumably there is some dependency on some tree that someone has
> forgotten to merge :-(
> 
Hmm...I thought it should be fine once Mike's clk tree is landing into the
-next tree. Firstly sorry about that and how should I do in this case?

> I reverted that commit for today.
> 
> Which then got to:
> 
> /scratch/sfr/next/arch/arm/boot/dts/exynos5420-peach-pit.dts:15:46: fatal error: dt-
> bindings/clock/maxim,max77802.h: No such file or directory
>  #include <dt-bindings/clock/maxim,max77802.h>
>                                               ^
> compilation terminated.
> /scratch/sfr/next/arch/arm/boot/dts/exynos5800-peach-pi.dts:15:46: fatal error: dt-
> bindings/clock/maxim,max77802.h: No such file or directory
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
> 
So sorry, actually it's my fault, I missed the information to arm-soc when I
sent a pull-request, just I thought arm-soc were aware of that before happening
the error when samsung tree merged...

- Kukjin

> I have used the arm-soc tree form next-20141001 for today (which still
> needs 5 reverts to get it to build :-().
