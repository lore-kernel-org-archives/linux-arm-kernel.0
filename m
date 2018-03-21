From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 20 Mar 2018 23:10:04 -0500
Subject: [PATCHv6 1/3] dt-bindings: documentation: add clock bindings
 information for Stratix10
In-Reply-To: <152148291051.242365.11482305337775703728@swboyd.mtv.corp.google.com>
References: <1519656455-14629-1-git-send-email-dinguyen@kernel.org>
 <152148291051.242365.11482305337775703728@swboyd.mtv.corp.google.com>
Message-ID: <1b10d9b1-3b2a-9c62-4817-e925fbd3bb77@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/19/2018 01:08 PM, Stephen Boyd wrote:
> Quoting Dinh Nguyen (2018-02-26 06:47:33)
>> diff --git a/Documentation/devicetree/bindings/clock/intc_stratix10.txt b/Documentation/devicetree/bindings/clock/intc_stratix10.txt
>> new file mode 100644
>> index 0000000..0652ff1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/intc_stratix10.txt
>> @@ -0,0 +1,51 @@
>> +Device Tree Clock bindings for Intel's SoCFPGA Stratix10 platform
>> +
>> +This binding uses the common clock binding[1].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +- compatible : shall be
>> +       "intel,stratix10-clkmgr"
>> +
>> +- reg : shall be the control register offset from CLOCK_MANAGER's base for the clock.
>> +
>> +- #clock-cells : from common clock binding, shall be set to 1.
>> +
>> +- clocks : Should contain fixed-clock sources, such as oscillators.
>> +
>> +Example:
>> +       clkmgr: clock-controller at ffd10000 {
>> +               compatible = "intel,stratix10-clkmgr";
>> +               reg = <0xffd10000 0x1000>;
>> +               #clock-cells = <1>;
>> +
>> +               clocks {
> 
> Why do we need a subnode for clocks inside of a clock controller node?
> 
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
>> +                               #clock-cells = <0>;
>> +                               compatible = "fixed-clock";
>> +                               clock-frequency = <25000000>;
> 
> What is this for? I would think oscillators go into the root of the DT
> because they're on the board, not inside the clock controller.
> 

Thanks for the review! I'll move the PLLs into the root of the DT.

Dinh
