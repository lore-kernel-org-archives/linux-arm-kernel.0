From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 18 Dec 2017 17:45:56 +0100
Subject: [PATCH v2] arm: kirkwood: dts: Use lower case for bindings
 notation
In-Reply-To: <20171215214354.GA31157@lunn.ch> (Andrew Lunn's message of "Fri,
 15 Dec 2017 22:43:54 +0100")
References: <20171215124653.30902-1-malat@debian.org>
 <20171215170711.8212-1-malat@debian.org>
 <20171215214354.GA31157@lunn.ch>
Message-ID: <871sjshtmj.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,
 
 On ven., d?c. 15 2017, Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Dec 15, 2017 at 06:07:11PM +0100, Mathieu Malaterre wrote:
>> Improve the DTS files using lower case to fix the following dtc warnings:
>> 
>> Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"
>> 
>> Converted using the following command:
>> 
>> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C
>> 
>> For simplicity, two sed expressions were used to solve each warnings separately.
>> 
>> To make the regex expression more robust a few other issues were resolved,
>> namely setting unit-address to lower case, and adding a whitespace before the
>> the opening curly brace:
>> 
>> https://elinux.org/Device_Tree_Linux#Linux_conventions
>> 
>> This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")
>> 
>> Reported-by: David Daney <ddaney@caviumnetworks.com>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>
> Thanks for fixing up the commit message.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied on mvebu/dt

Thanks,

Gregory

>
>     Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
