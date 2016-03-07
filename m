From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Mar 2016 08:32:11 -0800
Subject: [GIT PULL] ARM: OMAP2+: critical DRA7xx fix for v4.5-rc
In-Reply-To: <alpine.DEB.2.02.1603070933530.3437@utopia.booyaka.com>
References: <alpine.DEB.2.02.1603070933530.3437@utopia.booyaka.com>
Message-ID: <20160307162149.GA9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd & Olof,

Can you please pull this directly from Paul for v4.5?

* Paul Walmsley <paul@pwsan.com> [160307 01:38]:
> Tony,
> 
> These changes should go upstream immediately.
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.5-rc/omap-critical-fixes-a
> 
> for you to fetch changes up to 0f514e690740e54815441a87708c3326f8aa8709:
> 
>   ARM: dts: dra7: do not gate cpsw clock due to errata i877 (2016-03-07 01:41:22 -0700)
> 
> ----------------------------------------------------------------
> ARM: OMAP2+: critical DRA7xx fix for v4.5-rc
> 
> Force the DRA7xx Ethernet internal clock source to stay enabled
> per TI erratum i877:
> 
> http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
> 
> Otherwise, if the Ethernet internal clock source is disabled, the
> chip will age prematurely, and the RGMII I/O timing will soon
> fail to meet the delay time and skew specifications for 1000Mbps
> Ethernet.
> 
> This fix should go in as soon as possible.
> 
> Basic build, boot, and PM test results are available here:
> 
> http://www.pwsan.com/omap/testlogs/omap-critical-fixes-for-v4.5-rc/20160307014209/
> 
> ----------------------------------------------------------------
> Lokesh Vutla (1):
>       ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property
> 
> Mugunthan V N (1):
>       ARM: dts: dra7: do not gate cpsw clock due to errata i877
> 
>  Documentation/devicetree/bindings/arm/omap/omap.txt |  1 +
>  arch/arm/boot/dts/dra7.dtsi                         | 10 ++++++++++
>  arch/arm/mach-omap2/omap_hwmod.c                    |  9 ++++++++-
>  arch/arm/mach-omap2/omap_hwmod.h                    |  3 +++
>  4 files changed, 22 insertions(+), 1 deletion(-)
