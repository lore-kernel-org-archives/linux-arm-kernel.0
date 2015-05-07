From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 06 May 2015 17:30:45 -0700
Subject: [PATCH 1/2] dt-bindings: Add pxa1928 clock binding
In-Reply-To: <CAL_JsqJmpLw_iNXz5vZt9qcoR_CSRum3hB4fVYtERBsB=v=H8Q@mail.gmail.com>
References: <1430455271-20195-1-git-send-email-robh@kernel.org>
 <20150506071708.GD27050@codeaurora.org>
 <CAL_JsqJmpLw_iNXz5vZt9qcoR_CSRum3hB4fVYtERBsB=v=H8Q@mail.gmail.com>
Message-ID: <554AB235.5030300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/15 06:05, Rob Herring wrote:
> On Wed, May 6, 2015 at 2:17 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 04/30, Rob Herring wrote:
>>> diff --git a/Documentation/devicetree/bindings/clock/marvell,pxa1928.txt b/Documentation/devicetree/bindings/clock/marvell,pxa1928.txt
>>> new file mode 100644
>>> index 0000000..809c5a2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/marvell,pxa1928.txt
>>> @@ -0,0 +1,21 @@
>>> +* Marvell PXA1928 Clock Controllers
>>> +
>>> +The PXA1928 clock subsystem generates and supplies clock to various
>>> +controllers within the PXA1928 SoC. The PXA1928 contains 3 clock controller
>>> +blocks called APMU, MPMU, and APBC roughly corresponding to internal buses.
>>> +
>>> +Required Properties:
>>> +
>>> +- compatible: should be one of the following.
>>> +  - "marvell,pxa1928-apmu" - APMU controller compatible
>>> +  - "marvell,pxa1928-mpmu" - MPMU controller compatible
>>> +  - "marvell,pxa1928-apbc" - APBC controller compatible
>>> +- reg: physical base address of the clock controller and length of memory mapped
>>> +  region.
>>> +- #clock-cells: should be 1.
>>> +- #reset-cells: should be 1.
>>> +
>>> +Each clock is assigned an identifier and client nodes use the clock controller
>>> +phandle and this identifier to specify the clock which they consume.
>>> +
>>> +All these identifiers can be found in <dt-bindings/clock/marvell,pxa1928.h>.
>> No example?
> There's nothing really special about this binding to show.

Ok.

>
>>> diff --git a/include/dt-bindings/clock/marvell,pxa1928.h b/include/dt-bindings/clock/marvell,pxa1928.h
>>> new file mode 100644
>>> index 0000000..c393ca2
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/marvell,pxa1928.h
>>> @@ -0,0 +1,57 @@
>>> +#ifndef __DTS_MARVELL_PXA1928_CLOCK_H
>>> +#define __DTS_MARVELL_PXA1928_CLOCK_H
>>> +
>>> +/*
>>> + * Clock ID values here correspond to the control register offset/4.
>>> + */
>>> +
>>> +/* apb periphrals */
>> s/periphrals/peripherals/ ?
> Uhh, cut-n-paste from marvell,mmp2.h...
>>> +#define PXA1928_CLK_RTC                      0
>>> +#define PXA1928_CLK_TWSI0            1
>>> +#define PXA1928_CLK_TWSI1            2
>>> +#define PXA1928_CLK_TWSI2            3
>>> +#define PXA1928_CLK_TWSI3            4
>>> +#define PXA1928_CLK_OWIRE            5
>>> +#define PXA1928_CLK_KPC                      6
>>> +#define PXA1928_CLK_TB_ROTARY                7
>>> +#define PXA1928_CLK_SW_JTAG          8
>>> +#define PXA1928_CLK_TIMER1           9
>> This is really nitpicky, but I find the jump from decimal to hex odd.
>> Is there any reason why we don't just use decimal or hex throughout?
>> Perhaps it's related to why there are holes in the number space?
> What is 9 in hex? ;) I'll prefix them. It's hard to convert decimal to
> register values.
>

:) Thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
