From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 12 Jan 2015 16:18:47 +0100
Subject: [PATCH] Added support for pogoplug e02 (pink/gray)
In-Reply-To: <1421043061-2837-1-git-send-email-ottxor@gentoo.org>
References: <CAA8MNVjieDJ-dv2NNWXK=+uqrPmvtk2EiBYJGJkMugEiN2TsAw@mail.gmail.com>
 <1421043061-2837-1-git-send-email-ottxor@gentoo.org>
Message-ID: <20150112151847.GD8094@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 11:11:01PM -0700, Christoph Junghans wrote:
> The pogoplug differs from the SheevaPlug only by a
> few details, but especially in the led assignments.
> This patch was tested under Gentoo Linux.
> A version of this patch was included in Arch Linux
> on Arm since Jun 2014:
> https://github.com/archlinuxarm/PKGBUILDs/commit/250c2f0aa6ffe66c0ebda61efaa356e5dc709cc7
> A similar patch is available for OpenWrt:
> https://dev.openwrt.org/browser/trunk/target/linux/kirkwood/patches-3.14/150-pogoplug_e02.patch
> 
> Suggested-by: Felix Kaechele <heffer@fedoraproject.org>
> Suggested-by: Oleg Rakhmanov <moonman.ca@gmail.com>
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/kirkwood-pogo_e02.dts            | 114 +++++++++++++++++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-pogo_e02.dts
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..e5f58c6 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -32,6 +32,7 @@ cdns	Cadence Design Systems Inc.
>  chrp	Common Hardware Reference Platform
>  chunghwa	Chunghwa Picture Tubes Ltd.
>  cirrus	Cirrus Logic, Inc.
> +cloudengines	Cloud Engines, Inc.
>  cortina	Cortina Systems, Inc.
>  crystalfontz	Crystalfontz America, Inc.
>  dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile

Hi Christoph

Please make sure the device tree maintainers see this part of the
patch. I added them as Cc:

We can however take this change via mvebu->arm-soc if nobody objects.

   Andrew
