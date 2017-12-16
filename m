From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sat, 16 Dec 2017 22:12:14 +0100
Subject: [PATCH 19/25] arm: mt7: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215124652.30852-1-malat@debian.org>
References: <20171215124652.30852-1-malat@debian.org>
Message-ID: <94decad7-c801-fd23-b98f-e0307160a9aa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/15/2017 01:46 PM, Mathieu Malaterre wrote:
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
>  arch/arm/boot/dts/mt7623n-rfb-nand.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Pushed to v4.15-next/dts32

Thanks a lot,
Matthias
