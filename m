From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 17:28:48 +0200
Subject: [PATCH 1/2] ARM: dts: vf500/vf610: support VF500 SoC
In-Reply-To: <1412261724-11073-1-git-send-email-stefan@agner.ch>
References: <1412261724-11073-1-git-send-email-stefan@agner.ch>
Message-ID: <8882221.sfQOLcQs3p@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 October 2014 16:55:23 Stefan Agner wrote:
> The VF500 is essentially the same SoC, but with only one core and
> without L1 cache. The VF610 is therefore a superset of the VF500.
> Move allmost all periperals to vf500.dtsi which is then included
> and enhanced by vf610.dtsi.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Somehow using -M -B switches create a unapplyable patch, hence I
> generated one without those options. Sorry about that.
> 
>  arch/arm/boot/dts/vf500.dtsi | 498 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/vf610.dtsi | 507 +------------------------------------------
>  2 files changed, 510 insertions(+), 495 deletions(-)
>  create mode 100644 arch/arm/boot/dts/vf500.dtsi

I think it would be better to create one extra file that contains the common
parts and is included by both vf500 and vf610.

	Arnd
