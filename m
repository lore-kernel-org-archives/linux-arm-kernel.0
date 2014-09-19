From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 19 Sep 2014 09:43:34 +0200
Subject: [PATCH 0/3 v3] Fix Exynos USB on kernels with USB Gadget support
In-Reply-To: <1410778354-31210-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1410778354-31210-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1411112614.29071.1.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Kukjin,

It's been almost a month since I posted the first iteration of this
patchset on the list, with only trivial cosmetic changes and an addition
of a similar fix for Arndale Octa boards. Do you feel it needs more
review from specific folks before pulling it in or ?

Seems a bit of a shame if this would fail to make it for 3.18 (one could
even argue the dt patches are 3.17 RC material!) as it fixes USB
functionality being broken depending on the kernel configuration used.


On Mon, 2014-09-15 at 12:52 +0200, Sjoerd Simons wrote:
> When building a kernel with support for both USB host and USB Gadget support on
> the dwc3 controller on the Exynos5 soc will go into USB OTG mode unless
> otherwise specified in the dtb, which is unhelpful for boards hooked up to run
> as USB host.
> 
> First patch in this set explicitely set the dual-role mode for the dwc3
> controller on Peach pi and Peach pit boards to host mode. Second patch adds
> similar updates for Arndale Octa as reported by Andreas F?rber. Last patch
> enables gadget mode in the default exynos config to more easily catch/trigger
> issues like these.
> 
> I suspect the Samsung SMDK5420 DTS might need similar changes, so it would be
> great if users of those board could verify this.
> 
> Changes in v2: alphabetically sort the dts entries
> Changes in v3: Add DTS updates for arndale octa
> 
> Sjoerd Simons (3):
>   ARM: dts: exynos: Explicitly set dr_mode on peach-pit and peach-pi
>   ARM: dts: exynos: Explicitly set dr_mode on arndale-octa
>   ARM: exynos_defconfig: enable USB gadget support
> 
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts | 4 ++++
>  arch/arm/boot/dts/exynos5420-peach-pit.dts    | 8 ++++++++
>  arch/arm/boot/dts/exynos5420.dtsi             | 4 ++--
>  arch/arm/boot/dts/exynos5800-peach-pi.dts     | 8 ++++++++
>  arch/arm/configs/exynos_defconfig             | 1 +
>  5 files changed, 23 insertions(+), 2 deletions(-)
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140919/b4464251/attachment.bin>
