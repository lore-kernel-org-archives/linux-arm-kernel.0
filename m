From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 11 Dec 2013 23:40:39 +0800
Subject: [PATCH 3/3] clk: hisilicon: add hi3620_mmc_clks
In-Reply-To: <201312111544.47519.arnd@arndb.de>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
 <1386770541-15056-4-git-send-email-zhangfei.gao@linaro.org>
 <201312111544.47519.arnd@arndb.de>
Message-ID: <52A88777.9030502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/11/2013 10:44 PM, Arnd Bergmann wrote:
> On Wednesday 11 December 2013, Zhangfei Gao wrote:
>> +PCTRL: Peripheral misc control register
>> +
>> +Required Properties:
>> +- compatible: "hisilicon,pctrl"
>> +- reg: Address and size of pctrl.
>> +
>> +Example:
>> +
>> +       /* for Hi3620 */
>> +       pctrl: pctrl at fca09000 {
>> +               compatible = "hisilicon,pctrl";
>> +               reg = <0xfca09000 0x1000>;
>> +       };
>
> It seems you are missing the clock specific parts of the binding:
> You should document the required value of #clock-cells as well as
> the possible values for the clock specifier.
>

It is reuse Documentation/devicetree/bindings/clock/hi3620-clock.txt via 
adding hisilicon,hi3620-mmc-clock"

- compatible: should be one of the following.
   - "hisilicon,hi3620-clock" - controller compatible with Hi3620 SoC.
+  - "hisilicon,hi3620-mmc-clock" - controller specific for Hi3620 mmc.

- reg: physical base address of the controller and length of memory mapped
   region.

- #clock-cells: should be 1.

Thanks
