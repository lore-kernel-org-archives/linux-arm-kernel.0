From: architt@codeaurora.org (Archit Taneja)
Date: Fri, 9 Jun 2017 09:41:00 +0530
Subject: [PATCH v3 2/6] dt-bindings: display: Add Synopsys DW MIPI DSI DRM
 bridge driver
In-Reply-To: <20170608154028.6ck3dos6de2dogrk@rob-hp-laptop>
References: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
 <1496414235-20098-3-git-send-email-philippe.cornu@st.com>
 <20170608154028.6ck3dos6de2dogrk@rob-hp-laptop>
Message-ID: <7502cbc2-9feb-4dd3-3d95-b5f33b8a8872@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe, Rob,

On 06/08/2017 09:10 PM, Rob Herring wrote:
> On Fri, Jun 02, 2017 at 04:37:11PM +0200, Philippe CORNU wrote:
>> This patch adds documentation of device tree bindings for the
>> Synopsys DesignWare MIPI DSI host DRM bridge driver.
>>

Could you drop "DRM bridge driver" from the subject and commit message and
replace it with just "bridge" or "controller". DT bindings shouldn't mention
drivers.

>> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
>> ---
>>   .../bindings/display/bridge/dw_mipi_dsi.txt        | 30 ++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
>> new file mode 100644
>> index 0000000..1d7c438
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
>> @@ -0,0 +1,30 @@
>> +Synopsys DesignWare MIPI DSI host controller
>> +============================================
>> +
>> +This document defines device tree properties for the Synopsys DesignWare MIPI
>> +DSI host controller. It doesn't constitue a device tree binding specification

s/constitue/constitute

>> +by itself but is meant to be referenced by platform-specific device tree
>> +bindings.
>> +
>> +When referenced from platform device tree bindings the properties defined in
>> +this document are defined as follows. The platform device tree bindings are
>> +responsible for defining whether each property is required or optional.
>> +
>> +- reg: Memory mapped base address and length of the DWC MIPI DSI
>> +  registers. (mandatory)
>> +
>> +- clocks: References to all the clocks specified in the clock-names property
>> +  as specified in [1]. (mandatory)
>> +
>> +- clock-names: "pclk" is peripheral clock for either AHB and APB. (mandatory)
> 
> Seems strange there's not also a pixel or bit clock? Or this gets driven
> from the phy?

Since you mention phy here, I wanted to share a concern with the bindings.
These bindings don't have a separate PHY DT node. The PHY is assumed as a
part of the IP when integrated by a SoC. There are already rockchip and
hisil DSI bindings that use this IP but don't define a PHY node.

It's a similar situation with the DW-HDMI bindings.

For example, when the DW HDMI is integrated in rockchip or renesas SoC, the
bindings "rockchip,rk3288-dw-hdmi" or "renesas,r8a7795-dw-hdmi" are used,
and they don't have a separate PHY DT node.

I wasn't sure whether this is the right way to proceed or not for such IPs.
Some advice would help us here.

Thanks,
Archit

> 
>> +
>> +- resets: References to all the resets specified in the reset-names property
>> +  as specified in [2]. (optional)
>> +
>> +- reset-names: string reset name, must be "apb" if used. (optional)
>> +
>> +- panel or bridge node: see [3]. (mandatory)
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +[2] Documentation/devicetree/bindings/reset/reset.txt
>> +[3] Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
>> -- 
>> 1.9.1
>>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
