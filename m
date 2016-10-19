From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Oct 2016 21:45:29 -0500
Subject: [PATCH 2/3] clk: hisilicon: add CRG driver for Hi3516CV300 SoC
In-Reply-To: <7ce2e35b-19e1-9493-90a7-15b321fee2cc@hisilicon.com>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
 <20161017120705.3726-3-wenpan@hisilicon.com>
 <20161018155835.qyoffwznacdac46y@rob-hp-laptop>
 <7ce2e35b-19e1-9493-90a7-15b321fee2cc@hisilicon.com>
Message-ID: <CAL_JsqK18RHFhDSWA_j+v_pJL6vk+a=GD7oo6O3JJaV4hHHEBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 9:38 PM, Jiancheng Xue
<xuejiancheng@hisilicon.com> wrote:
>
>
> ? 2016/10/18 23:58, Rob Herring ??:
>> On Mon, Oct 17, 2016 at 08:07:04PM +0800, Pan Wen wrote:
>>> Add CRG driver for Hi3516CV300 SoC. CRG(Clock and Reset
>>> Generator) module generates clock and reset signals used
>>> by other module blocks on SoC.
>>>
>>> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
>>> ---
>>>  .../devicetree/bindings/clock/hisi-crg.txt         |  50 ++++
>>>  drivers/clk/hisilicon/Kconfig                      |   8 +
>>>  drivers/clk/hisilicon/Makefile                     |   1 +
>>>  drivers/clk/hisilicon/crg-hi3516cv300.c            | 330 +++++++++++++++++++++
>>>  drivers/clk/hisilicon/crg.h                        |  34 +++
>>>  include/dt-bindings/clock/hi3516cv300-clock.h      |  48 +++
>>>  6 files changed, 471 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/hisi-crg.txt
>>>  create mode 100644 drivers/clk/hisilicon/crg-hi3516cv300.c
>>>  create mode 100644 drivers/clk/hisilicon/crg.h
>>>  create mode 100644 include/dt-bindings/clock/hi3516cv300-clock.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
>>> new file mode 100644
>>> index 0000000..cc60b3d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/hisi-crg.txt
>>> @@ -0,0 +1,50 @@
>>> +* HiSilicon Clock and Reset Generator(CRG)
>>
>> Seems kind of generic given there's already various HiSi clock bindings
>> documented.
>>
>>> +
>>> +The CRG module provides clock and reset signals to various
>>> +modules within the SoC.
>>> +
>>> +This binding uses the following bindings:
>>> +    Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> +    Documentation/devicetree/bindings/reset/reset.txt
>>> +
>>> +Required Properties:
>>> +
>>> +- compatible: should be one of the following.
>>> +  - "hisilicon,hi3516cv300-crg"
>>> +  - "hisilicon,hi3516cv300-sysctrl"
>>> +  - "hisilicon,hi3519-crg"
>>
>> There is already a binding for this. Please merge them.
>>
> Hi Rob,
>
> Pan Wen and I work together. There's really a same file included in the patch
> https://lkml.org/lkml/2016/9/18/42 ([PATCH v2] clk: hisilicon: add CRG driver for Hi3798CV200 SoC).
> But that patch has not been acked. This binding file will be merged if that
> patch is accepted first. Could you give me more comments on that patch or
> help me to ack it?  Thank you very much.

If I haven't commented, then likely it was not sent to the DT list.

Rob
