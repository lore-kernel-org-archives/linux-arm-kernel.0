From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 26 Sep 2013 09:38:19 +0200
Subject: [PATCH 0/5] Add Core Divider clock support for Armada 370/XP
In-Reply-To: <20130925213730.GA19371@localhost>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130925213730.GA19371@localhost>
Message-ID: <5243E46B.2000406@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On 25/09/2013 23:37, Ezequiel Garcia wrote:
> (Ccing forgotten mvebu maintainers)
> 
> On Wed, Sep 25, 2013 at 06:28:17PM -0300, Ezequiel Garcia wrote:
>> This patchset adds support for a set of clocks available in Armada 370/XP
>> known as "Core Divider" clocks.
>>
>> These are a set of gatable clocks, derived from a fixed PLL at
>> a configurable ratio. Although this patchset adds support for the more
>> general case, we only support one of the clocks, namely the NAND ECC clock.
>>
>> With this infrastructure in place, the addition of the rest of the clocks
>> would be fairly easy.
>>
>> In addition, the NAND clock is added as a fixed-ratio from the NAND ECC clock,
>> to model accurately the SoC clock tree.
>>
>> A pictorical representation of the clock tree would be:
>>
>>     PLL
>>     |
>>     |
>>     ---------------------
>>     |			|
>>     |			|
>>     NAND ECC clock	...
>>     |
>>     |
>>     NAND clock
>>
>> This patchset is based on v3.12-rc2. Any opinions are highly appreciated.
>>

For the whole series you can add my
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

I just wonder if you were enable to test the enable and disable for the clock,
because the datasheet is a little fuzzy about it.

Thanks,

Gregory
>> Thanks!
>>
>> Ezequiel Garcia (5):
>>   clk: mvebu: Add core-divider clock
>>   ARM: mvebu: Add Core Divider clock device-tree binding
>>   ARM: mvebu: Add a 2 GHz fixed-clock Armada 370/XP
>>   ARM: mvebu: Add the core-divider clock to Armada 370/XP
>>   ARM: mvebu: Add NAND clock to Armada 370/XP
>>
>>  .../bindings/clock/mvebu-corediv-clock.txt         |  19 ++
>>  arch/arm/boot/dts/armada-370-xp.dtsi               |  25 +++
>>  drivers/clk/mvebu/Kconfig                          |   5 +
>>  drivers/clk/mvebu/Makefile                         |   1 +
>>  drivers/clk/mvebu/clk-corediv.c                    | 209 +++++++++++++++++++++
>>  5 files changed, 259 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
>>  create mode 100644 drivers/clk/mvebu/clk-corediv.c
>>
>> -- 
>> 1.8.1.5
>>
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
