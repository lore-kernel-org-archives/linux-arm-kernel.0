From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 9 Jun 2017 12:59:25 +0200
Subject: [PATCH 3/3] arm: dts: mt2701: Add display subsystem related nodes
 for MT2701
In-Reply-To: <1496996562.2343.3.camel@pengutronix.de>
References: <1496297324-21091-1-git-send-email-erin.lo@mediatek.com>
 <1496297324-21091-4-git-send-email-erin.lo@mediatek.com>
 <eafa6c79-4d12-abf5-f8ec-e91c6cc22cd4@gmail.com>
 <1496996562.2343.3.camel@pengutronix.de>
Message-ID: <6cd7cde6-dfb4-5134-6580-e0589e731258@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/06/17 10:22, Philipp Zabel wrote:
> Hi Matthias,
> 
> On Fri, 2017-06-09 at 10:14 +0200, Matthias Brugger wrote:
>>
>> On 01/06/17 08:08, Erin Lo wrote:
>>> From: YT Shen <yt.shen@mediatek.com>
>>>
>>> This patch adds the device nodes for the DISP function blocks for MT2701
>>>
>>> Signed-off-by: YT Shen <yt.shen@mediatek.com>
>>> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
>>> ---
>>>    arch/arm/boot/dts/mt2701.dtsi | 84 +++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 84 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
>>> index 4f110d5..e20b65c 100644
>>> --- a/arch/arm/boot/dts/mt2701.dtsi
>>> +++ b/arch/arm/boot/dts/mt2701.dtsi
>>> @@ -17,6 +17,7 @@
>>>    #include <dt-bindings/interrupt-controller/irq.h>
>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>    #include <dt-bindings/reset/mt2701-resets.h>
>>> +#include <dt-bindings/memory/mt2701-larb-port.h>
>>>    #include "skeleton64.dtsi"
>>>    #include "mt2701-pinfunc.h"
>>>    
>>> @@ -24,6 +25,11 @@
>>>    	compatible = "mediatek,mt2701";
>>>    	interrupt-parent = <&sysirq>;
>>>    
>>> +	aliases {
>>> +		rdma0 = &rdma0;
>>> +		rdma1 = &rdma1;
>>> +	};
>>> +
>>
>> I know we have this alias in mt8173.dtsi, but I don't understand what
>> they are for. Do you know?
> 
> The mtk_disp_rdma platform driver uses mtk_ddp_comp_get_id() to identify
> the specific RDMA instance, which calls of_alias_get_id(). The core code
> needs to know which RDMA is which to correctly set up the display data
> paths.
> 

Ok, thanks for the clarification!

Matthias
