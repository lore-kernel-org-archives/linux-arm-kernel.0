From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Dec 2017 17:53:13 -0200
Subject: [PATCH v3] arm: imx: dts: Use lower case for bindings notation
In-Reply-To: <20171215191930.11410-1-malat@debian.org>
References: <20171215124631.30132-1-malat@debian.org>
 <20171215191930.11410-1-malat@debian.org>
Message-ID: <CAOMZO5BYU5E7g5DZDOCHjjkkcEMFvQefHfRU+x7eg6u_8e0U8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 5:19 PM, Mathieu Malaterre <malat@debian.org> wrote:
> Improve the DTS files using lower case to fix the following dtc warnings:
>
> Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"
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
> This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")
>
> Reported-by: David Daney <ddaney@caviumnetworks.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
