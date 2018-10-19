From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Fri, 19 Oct 2018 23:50:08 +0800
Subject: [PATCH v5 2/3] clk: meson: add DT documentation for emmc clock
 controller
In-Reply-To: <153988248599.5275.8444799485095155762@swboyd.mtv.corp.google.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-3-git-send-email-jianxin.pan@amlogic.com>
 <153988248599.5275.8444799485095155762@swboyd.mtv.corp.google.com>
Message-ID: <efc5b030-f344-80ce-f57e-582207f436fe@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/10/19 1:08, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-10-17 22:07:24)
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>> new file mode 100644
>> index 0000000..9e6d343
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>> @@ -0,0 +1,31 @@
>> +* Amlogic MMC Sub Clock Controller Driver
>> +
>> +The Amlogic MMC clock controller generates and supplies clock to support
>> +MMC and NAND controller
>> +
>> +Required Properties:
>> +
>> +- compatible: should be:
>> +               "amlogic,gx-mmc-clkc"
>> +               "amlogic,axg-mmc-clkc"
>> +
>> +- #clock-cells: should be 1.
>> +- clocks: phandles to clocks corresponding to the clock-names property
>> +- clock-names: list of parent clock names
>> +       - "clkin0", "clkin1"
>> +
>> +Parent node should have the following properties :
> 
> The example only has one node. Can you add two nodes?
OK. This clock is used by nand and emmc. I will add a new example for emmc too.
Thank you for your review.
> 
>> +- compatible: "amlogic,axg-mmc-clkc", "syscon".
>> +- reg: base address and size of the MMC control register space.
>> +
>> +Example: Clock controller node:
>> +
>> +sd_mmc_c_clkc: clock-controller at 7000 {
>> +       compatible = "amlogic,axg-mmc-clkc", "syscon";
>> +       reg = <0x0 0x7000 0x0 0x4>;
>> +       #clock-cells = <1>;
>> +
>> +       clock-names = "clkin0", "clkin1";
>> +       clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
>> +                <&clkc CLKID_FCLK_DIV2>;
>> +};
> 
> .
> 
