From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 16 Aug 2013 09:04:28 +0900
Subject: Broken device trees for exynos in linux-next
In-Reply-To: <CAOesGMgv9gTQ_NtaKZY_ZfLD1NBU19E-vaLaWwmvGJJB1MQrwg@mail.gmail.com>
References: <CAOesGMgv9gTQ_NtaKZY_ZfLD1NBU19E-vaLaWwmvGJJB1MQrwg@mail.gmail.com>
Message-ID: <13b101ce9a14$2cebd700$86c38500$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Kukjin,
> 
Hi, Olof,

> On Thu, Aug 15, 2013 at 12:34 AM,  <build@lixom.net> wrote:
> 
> >         exynos5440_defconfig:
> > ERROR: Input tree has errors, aborting (use -f to force output)
> >
> >         exynos_defconfig:
> > ERROR: Input tree has errors, aborting (use -f to force output)
> 
> Full error is:
> 
>   DTC     arch/arm/boot/dts/exynos5420-smdk5420.dtb
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma1"
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma1"
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma0"
> ERROR (phandle_references): Reference to non-existent node or label
> "pdma0"
> 
> Looks like you have broken device trees in linux next.

(+ Mark)

NO, the build breakage is due to commit 6187288f15bc ("ARM: dts: exynos5250:
move common i2s properties to exynos5 dtsi" which is in Mark Brown's tree.

Mark, pleaser revert it in your tree...

> Also, what is exynos5440_defconfig?

(+ Arnd)

I think, maybe we discussed about that? :) current exynos_defconfig cannot
support exynos5440 because of LPAE and I remember we decided LPAE and
non-LPAE should be separated. So as I commented before, exynos5440_defconfig
is needed. If you have any concerns, please let me know.

> Don't add contents (which includes defconfigs)
> to linux-next branches that won't make it all the way upstream.
> 
Sure :)

Thanks,
Kukjin
