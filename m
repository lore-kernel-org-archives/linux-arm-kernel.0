From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:34:38 +0100
Subject: [PATCH 02/25] arm: at91/sama: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215124627.29979-1-malat@debian.org>
References: <20171215124627.29979-1-malat@debian.org>
Message-ID: <20171219213438.GQ15162@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/2017 at 13:46:26 +0100, Mathieu Malaterre wrote:
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
>  arch/arm/boot/dts/at91sam9261.dtsi     | 2 +-
>  arch/arm/boot/dts/at91sam9261ek.dts    | 2 +-
>  arch/arm/boot/dts/at91sam9263.dtsi     | 2 +-
>  arch/arm/boot/dts/at91sam9263ek.dts    | 2 +-
>  arch/arm/boot/dts/at91sam9g25ek.dts    | 2 +-
>  arch/arm/boot/dts/at91sam9g45.dtsi     | 2 +-
>  arch/arm/boot/dts/at91sam9m10g45ek.dts | 2 +-
>  arch/arm/boot/dts/sama5d3xmb.dtsi      | 2 +-
>  arch/arm/boot/dts/sama5d3xmb_cmp.dtsi  | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
