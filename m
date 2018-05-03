From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 3 May 2018 21:13:56 +0200
Subject: [PATCH v3] arm: exynos/s3c: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20180503184454.19131-1-malat@debian.org>
References: <20180502201153.7459-1-malat@debian.org>
 <20180503184454.19131-1-malat@debian.org>
Message-ID: <20180503191356.n6xo5qe7jnmr2krf@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 08:44:53PM +0200, Mathieu Malaterre wrote:
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
> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed  -i -e "s/@\([0-9a-fA-FxX\.;:#]\+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0\+\(.*\) {/@\1 {/g" {} +
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
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v3: remove extra 0 preventing correct fixup
> v2: intermediate patch contained unrelated changes. restrict to S3 and Exynos*
> 
>  arch/arm/boot/dts/exynos5420.dtsi             | 36 +++++++++++++--------------
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  2 +-
>  arch/arm/boot/dts/s3c2416.dtsi                |  8 +++---
>  3 files changed, 23 insertions(+), 23 deletions(-)
> 

Thanks, applied after running the command to include few more changes.

Best regards,
Krzysztof
