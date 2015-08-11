From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 11 Aug 2015 13:00:06 +0900
Subject: [PATCH v4] dtb: Create a common home for cross-architecture dtsi
 files.
In-Reply-To: <1438617993-1012-1-git-send-email-ian.campbell@citrix.com>
References: <1438617993-1012-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <CAK7LNARyEbnOWTis0Nx9zwTcwH_s3GZKg2XYG3+zLnf=FhhctA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

2015-08-04 1:06 GMT+09:00 Ian Campbell <ian.campbell@citrix.com>:
> Commit 9ccd608070b6 ("arm64: dts: add device tree for ARM SMM-A53x2 on
> LogicTile Express 20MG") added a new dts file to arch/arm64 which
> included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
> .dtsi supplied by arch/arm.
>
> Unfortunately this causes some issues for the split device tree
> repository[0], since things get moved around there. In that context
> the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
> while the include is at src/arm/vexpress-v2m-rs1.dtsi.
>
> The sharing of the .dtsi is legitimate since the baseboard is the same
> for various vexpress systems whatever processor they use.
>
> Rather than using ../../ tricks to pickup .dtsi files from another
> arch this patch creates a new directory kernel/dts as a home for such
> cross-arch .dtsi files and arranges for it to be in the include path
> for both dtc and cpp. The dtsi file itself is moved into a vendor
> subdir in this case "arm" (the vendor, not the ARCH=).


Question:
If this patch is applied, which directory will be created in
device-tree-rebasing?
src/kernel/, src/common/, or something else?
Either will do, of course.


Another nit:
I just noticed a period at the end of the commit subject.
Re-post would not be needed only for such a minor thing,
but please try best to remember to drop it when this patch is applied.




-- 
Best Regards
Masahiro Yamada
