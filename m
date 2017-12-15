From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 15 Dec 2017 14:16:58 +0100
Subject: [PATCH 03/25] arm: bcm: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215124628.30029-1-malat@debian.org>
References: <20171215124628.30029-1-malat@debian.org>
Message-ID: <4642ee3f-ee51-91ed-5e34-883c1906dfd7@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Add Eric]

Am 15.12.2017 um 13:46 schrieb Mathieu Malaterre:
> Improve the DTS files by removing all the leading "0x" and zeros to fix the
> following dtc warnings:
>
> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
>
> and
>
> Warning (unit_address_format): Node /XXX unit name should not have leading 0s
>
> Converted using the following command:
>
> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C
>
> For simplicity, two sed expressions were used to solve each warnings separately.
>
> To make the regex expression more robust a few other issues were resolved,
> namely setting unit-address to lower case, and adding a whitespace before the
> the opening curly brace:
>
> https://elinux.org/Device_Tree_Linux#Linux_conventions
>
> This will solve as a side effect warning:
>
> Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"
>
> This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")
>
> Reported-by: David Daney <ddaney@caviumnetworks.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/arm/boot/dts/bcm11351.dtsi | 2 +-
>   arch/arm/boot/dts/bcm21664.dtsi | 2 +-
>   arch/arm/boot/dts/bcm283x.dtsi  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

only for bcm283x.dtsi

@Florian: I assume this should go through your tree directly.
