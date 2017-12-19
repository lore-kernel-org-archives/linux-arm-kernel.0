From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 19 Dec 2017 13:41:38 +0530
Subject: [PATCH 23/25] arm: da8: dts: Remove leading 0x and 0s from
 bindings notation
In-Reply-To: <20171215124657.31052-1-malat@debian.org>
References: <20171215124657.31052-1-malat@debian.org>
Message-ID: <708e10a7-5c92-661b-a0ba-0eb7476f2980@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 December 2017 06:16 PM, Mathieu Malaterre wrote:
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

Applied to v4.16/fixes-non-critical with some headline adjustments.

The subject prefix we use for this file is "ARM: dts: da850-lcdk:". You
can check that with 'git log --oneline'

Also, you are not fixing bindings notation here, but the actual device
tree source itself. So:

"
ARM: dts: da850-lcdk: Remove leading 0x and 0s from unit address
"

Thanks for the patch!
Sekhar
