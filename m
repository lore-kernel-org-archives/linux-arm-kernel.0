From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 18 Dec 2017 09:47:55 +0530
Subject: [PATCH 13/25] arm: spear: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215124645.30535-1-malat@debian.org>
References: <20171215124645.30535-1-malat@debian.org>
Message-ID: <20171218041755.GA19815@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-12-17, 13:46, Mathieu Malaterre wrote:
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
>  arch/arm/boot/dts/spear1310-evb.dts | 4 ++--
>  arch/arm/boot/dts/spear300.dtsi     | 2 +-
>  arch/arm/boot/dts/spear310.dtsi     | 2 +-
>  arch/arm/boot/dts/spear320-hmi.dts  | 4 ++--
>  arch/arm/boot/dts/spear320.dtsi     | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
