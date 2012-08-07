From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Aug 2012 20:29:08 +0000
Subject: =?euc-kr?q?=C8=B8=BD=C5=3A_=5BPATCH_2/4=5D_arm/dts=3A_exynos4=3A_Add_DTS?=
 =?euc-kr?q?_files_derived_from_common?= Exynos4
In-Reply-To: <A6A3B7488C419F488E5B13FFD03C08AD2F4372EB@SN2PRD0510MB370.namprd05.prod.outlook.com>
References: <1344366398-19022-1-git-send-email-dongjin.kim@agreeyamobility.net>
 <201208071938.26507.arnd@arndb.de>
 <A6A3B7488C419F488E5B13FFD03C08AD2F4372EB@SN2PRD0510MB370.namprd05.prod.outlook.com>
Message-ID: <201208072029.08693.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 August 2012, Dongjin Kim wrote:
> Hi,
> 
> I didn't use -M and I couldn't see any difference with the it.
> Did I make something wrong on that patch?

No, I think it's just git being less smart about file moves than I was hoping
for. It might do the right thing if you do the patch in two steps:

1. rename exynos4210.dtsi to exynos4.dtsi and add a one-line exynos4210.dtsi
file that just includes exynos4.dtsi.

2. do all the changes for moving contents back from exynos4.dtsi into
exynos4210.dtsi and exynos4412.dtsi.

Not sure if it's worth it though. Your version is probably good enough
if there are no tools to do a better job automatically.

	Arnd
