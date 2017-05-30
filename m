From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 30 May 2017 11:14:23 +0200
Subject: [PATCH 0/5] ARM: dts: at91: Migrate to the new EBI/NAND bindings
In-Reply-To: <1496133171-4787-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1496133171-4787-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170530111423.46c0e69e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 May 2017 10:32:45 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> This is the last step of the EBI/NAND bindings rework started here [1].
> 
> The first patch is adding missing nfc-io bindings doc to atmel-nand.txt
> and can be applied independently.
> 
> Patches 2 to 4 are migrating all at91/sama5 SoCs (except the
> at91rm9200) to the new EBI/NAND representation introduced in 4.12.
> 
> The last patch is showing how one can add a non-NAND device under the
> EBI bus.

Please ignore this version: I forgot to Cc board maintainers and patch
3 and 4 should be merged in a single patch.

I'll send a v2.

> 
> Regards,
> 
> Boris
> 
> [1]http://lkml.iu.edu/hypermail/linux/kernel/1703.2/00124.html
> 
> Boris Brezillon (5):
>   dt-bindings: mtd: atmel-nand: Document the nfc-io bindings
>   ARM: dts: at91: Declare EBI/NAND controllers
>   ARM: dts: at91: Update board dts to use the new EBI/NAND bindings
>   ARM: dts: at91: Get rid of old NAND definitions
>   ARM: dts: at91: Add the NOR flash available on sama5d3 dev kits
> 
>  .../devicetree/bindings/mtd/atmel-nand.txt         |  14 ++
>  arch/arm/boot/dts/aks-cdu.dts                      |  56 ++++---
>  arch/arm/boot/dts/animeo_ip.dts                    |  53 ++++--
>  arch/arm/boot/dts/at91-cosino.dtsi                 |  83 ++++++----
>  arch/arm/boot/dts/at91-kizbox.dts                  |  42 +++--
>  arch/arm/boot/dts/at91-kizbox2.dts                 |  45 ++++--
>  arch/arm/boot/dts/at91-kizboxmini.dts              |  52 ++++--
>  arch/arm/boot/dts/at91-linea.dtsi                  |  25 ++-
>  arch/arm/boot/dts/at91-qil_a9260.dts               | 103 +++++++-----
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  97 ++++++-----
>  arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  83 ++++++----
>  arch/arm/boot/dts/at91-sama5d4ek.dts               |  83 ++++++----
>  arch/arm/boot/dts/at91-tse850-3.dts                |  70 ++++----
>  arch/arm/boot/dts/at91sam9260.dtsi                 |  65 +++++---
>  arch/arm/boot/dts/at91sam9261.dtsi                 |  48 ++++--
>  arch/arm/boot/dts/at91sam9261ek.dts                |  83 ++++++----
>  arch/arm/boot/dts/at91sam9263.dtsi                 |  89 ++++++++---
>  arch/arm/boot/dts/at91sam9263ek.dts                | 103 +++++++-----
>  arch/arm/boot/dts/at91sam9g20ek_common.dtsi        | 103 +++++++-----
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |  64 +++++---
>  arch/arm/boot/dts/at91sam9m10g45ek.dts             |  49 ++++--
>  arch/arm/boot/dts/at91sam9n12.dtsi                 |  74 ++++++---
>  arch/arm/boot/dts/at91sam9n12ek.dts                |  26 ++-
>  arch/arm/boot/dts/at91sam9rl.dtsi                  |  69 +++++---
>  arch/arm/boot/dts/at91sam9rlek.dts                 |  85 ++++++----
>  arch/arm/boot/dts/at91sam9x5.dtsi                  | 134 ++++++++++------
>  arch/arm/boot/dts/at91sam9x5cm.dtsi                |  83 ++++++----
>  arch/arm/boot/dts/ethernut5.dts                    |  47 ++++--
>  arch/arm/boot/dts/ge863-pro3.dtsi                  |  41 +++--
>  arch/arm/boot/dts/pm9g45.dts                       |  99 ++++++------
>  arch/arm/boot/dts/sama5d2.dtsi                     |  53 ++++++
>  arch/arm/boot/dts/sama5d3.dtsi                     | 131 ++++++++++++---
>  arch/arm/boot/dts/sama5d3xcm.dtsi                  |  97 +++++++----
>  arch/arm/boot/dts/sama5d3xcm_cmp.dtsi              |  77 +++++----
>  arch/arm/boot/dts/sama5d4.dtsi                     | 177 ++++++++++++++++++---
>  arch/arm/boot/dts/tny_a9260_common.dtsi            |  89 +++++++----
>  arch/arm/boot/dts/tny_a9263.dts                    | 103 +++++++-----
>  arch/arm/boot/dts/usb_a9260_common.dtsi            | 103 +++++++-----
>  arch/arm/boot/dts/usb_a9263.dts                    | 103 +++++++-----
>  39 files changed, 1992 insertions(+), 1009 deletions(-)
> 
