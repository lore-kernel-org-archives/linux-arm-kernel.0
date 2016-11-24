From: zhangfei.gao@linaro.org (zhangfei)
Date: Thu, 24 Nov 2016 08:41:19 +0800
Subject: [PATCH 4/6] dt-bindings: change hi6220-reset.txt according to
 reset-hi6220.c
In-Reply-To: <20161123230637.m4cvc2l4huxlf5dd@rob-hp-laptop>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
 <1479800961-6249-5-git-send-email-zhangfei.gao@linaro.org>
 <2314383.qiZ3Cq7QsP@wuerfel> <20161123230637.m4cvc2l4huxlf5dd@rob-hp-laptop>
Message-ID: <b5451df3-2af5-1236-f1f4-a70ac2de9a3b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Rob


On 2016?11?24? 07:06, Rob Herring wrote:
> On Tue, Nov 22, 2016 at 09:48:32AM +0100, Arnd Bergmann wrote:
>> On Tuesday, November 22, 2016 3:49:19 PM CET Zhangfei Gao wrote:
>>>   Required properties:
>>>   - compatible: should be one of the following:
>>> -  - "hisilicon,hi6220-sysctrl", "syscon" : For peripheral reset controller.
>>> -  - "hisilicon,hi6220-mediactrl", "syscon" : For media reset controller.
>>> -- reg: should be register base and length as documented in the
>>> -  datasheet
>>> +  - "hisilicon,hi6220-reset-sysctrl" : For peripheral reset controller.
>>> +  - "hisilicon,hi6220-reset-mediactrl" : For media reset controller.
>>> +- hisi,rst-syscon: phandle of the reset's syscon.
>>>   - #reset-cells: 1, see below
>>>
>> Please keep the old strings around for compatibility.
> Why are these even changing? The commit message should say why.
Have send [RFC V2:PATCH 0/2] add reset-hi3660
Not touching this file any more.
Only handle hi3660.

But hi6220 can directly use the driver.
Only need list reset info to hi6220.dts, same as hi3660.
Like
+       iomcu_rst: iomcu_rst_controller {
+               compatible = "hisilicon,hi3660-reset";
+               #reset-cells = <1>;
+               hisi,rst-syscon = <&iomcu>;
+               hisi,reset-bits = <0x20 0x8             /* 0: i2c0 */
+                                  0x20 0x10            /* 1: i2c1 */
+                                  0x20 0x20            /* 2: i2c2 */
+                                  0x20 0x8000000>;     /* 3: i2c6 */
+       };

Thanks
