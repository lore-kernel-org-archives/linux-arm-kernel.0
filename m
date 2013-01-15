From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Jan 2013 09:43:45 +0800
Subject: [PATCH] clk: prima2: enable dt-binding clkdev mapping
In-Reply-To: <20130114215259.23734.68185@quantum>
References: <1355993491-21233-1-git-send-email-Barry.Song@csr.com>
 <20130114215259.23734.68185@quantum>
Message-ID: <CAGsJ_4wMsFk2EKuXtH5=+PJUSJrcg-tPJFU2bvbYvH_J8BEHJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

2013/1/15 Mike Turquette <mturquette@linaro.org>:
> Quoting Barry Song (2012-12-20 00:51:31)
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> this patche deletes hard code that registers clkdev by things like:
>> clk_register_clkdev(clk, NULL, "b0030000.nand");
>> clk_register_clkdev(clk, NULL, "b0040000.audio");
>> clk_register_clkdev(clk, NULL, "b0080000.usp");
>> prima2 clock controller becomes a clock provider and  every dt node
>> just declares its clock sources by dt prop.
>>
>> it also makes us easier to extend this driver to support both prima2
>> and marco as marco has different address mapping with prima2.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>
> Barry,
>
> The changes to clk-prima2.c look OK to me.  Did you want me to take this
> patch through clk-next?

yes. since it has no conflict with what i am handling in my machine codes.

>
> Thanks,
> Mike
>
>> ---
>>  .../devicetree/bindings/clock/prima2-clock.txt     |   73 +++++++
>>  arch/arm/boot/dts/prima2.dtsi                      |   31 +++-
>>  drivers/clk/clk-prima2.c                           |  205 ++++++++------------
>>  3 files changed, 183 insertions(+), 126 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/clock/prima2-clock.txt

-barry
