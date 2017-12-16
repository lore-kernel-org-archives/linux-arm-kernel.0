From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 16 Dec 2017 00:36:12 -0800
Subject: [PATCH 07/25] arm: keystone: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215124638.30233-1-malat@debian.org>
References: <20171215124638.30233-1-malat@debian.org>
Message-ID: <822c5d90-07b8-cde0-95a9-f56e5d219328@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/17 4:46 AM, Mathieu Malaterre wrote:
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
> https://urldefense.proofpoint.com/v2/url?u=https-3A__elinux.org_Device-5FTree-5FLinux-23Linux-5Fconventions&d=DwIBAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=hWpFvp_cTkkwMMULcvbV65orOO9Gv3OUaY0ATWhQwak&m=4zPLm6aGenI9keAZLborgvk3tLzaGsH_T4xXnh1mN3c&s=nCTYz6lbODdmoNqNYOTb6wm8nNYWW-AZlwiaUp7gpmM&e=
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
Looks good.
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
