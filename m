From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 11 Jan 2018 08:38:42 -0600
Subject: [PATCH 12/25] arm: socfpga: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215111620.20379-12-malat@debian.org>
References: <20171214165350.27850-1-malat@debian.org>
 <20171215111620.20379-1-malat@debian.org>
 <20171215111620.20379-12-malat@debian.org>
Message-ID: <a175eb79-56a1-5bad-9cc0-12fdbbadbaa5@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/15/2017 05:16 AM, Mathieu Malaterre wrote:
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
>  arch/arm/boot/dts/socfpga.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Dinh
