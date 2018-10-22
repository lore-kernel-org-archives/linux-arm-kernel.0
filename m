From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Mon, 22 Oct 2018 14:05:48 +0800
Subject: [PATCH v5 2/3] clk: meson: add DT documentation for emmc clock
 controller
In-Reply-To: <153997224756.53599.3138050846693192599@swboyd.mtv.corp.google.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-3-git-send-email-jianxin.pan@amlogic.com>
 <153988248599.5275.8444799485095155762@swboyd.mtv.corp.google.com>
 <efc5b030-f344-80ce-f57e-582207f436fe@amlogic.com>
 <153997224756.53599.3138050846693192599@swboyd.mtv.corp.google.com>
Message-ID: <2a3890e2-10a7-ef0a-637d-af980d495606@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for the fully review, we really appreciate your time.

Please see my comments below. 

On 2018/10/20 2:04, Stephen Boyd wrote:
> Quoting Jianxin Pan (2018-10-19 08:50:08)
>> On 2018/10/19 1:08, Stephen Boyd wrote:
>>> Quoting Jianxin Pan (2018-10-17 22:07:24)
>>>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>>> new file mode 100644
>>>> index 0000000..9e6d343
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
>>>> @@ -0,0 +1,31 @@
>>>> +* Amlogic MMC Sub Clock Controller Driver
>>>> +
>>>> +The Amlogic MMC clock controller generates and supplies clock to support
>>>> +MMC and NAND controller
>>>> +
>>>> +Required Properties:
>>>> +
>>>> +- compatible: should be:
>>>> +               "amlogic,gx-mmc-clkc"
>>>> +               "amlogic,axg-mmc-clkc"
>>>> +
>>>> +- #clock-cells: should be 1.
>>>> +- clocks: phandles to clocks corresponding to the clock-names property
>>>> +- clock-names: list of parent clock names
>>>> +       - "clkin0", "clkin1"
>>>> +
>>>> +Parent node should have the following properties :
>>>
>>> The example only has one node. Can you add two nodes?
>> OK. This clock is used by nand and emmc. I will add a new example for emmc too.
>> Thank you for your review.
> 
> Maybe I misunderstand. I thought the clk controller was two nodes, but
> it isn't? This wording is trying to explain what a consumer should look
> like?
> 
Yes.There is another clk controller.  I will add it in the next version.
sd_emmc_b_clkc: clock-controller at 5000 {                  
         compatible = "amlogic,axg-mmc-clkc", "syscon";   
         reg = <0x0 0x5000 0x0 0x4>;                      
         #clock-cells = <1>;                              
                                                          
         clock-names = "clkin0", "clkin1";                
         clocks = <&clkc CLKID_SD_EMMC_B_CLK0>,           
                 <&clkc CLKID_FCLK_DIV2>;                 
};
sd_emmc_c_clkc is for nadn and mmc portC.
sd_emmc_b_clkc is for mmc portB.
> .
> 
