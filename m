From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 10 Jan 2013 11:04:13 +0100
Subject: [PATCH 2/2] ARM: dts: omap: Add omap-usb2 dt data
In-Reply-To: <50EE8A89.4010801@ti.com>
References: <1348050772-27819-1-git-send-email-kishon@ti.com>
 <1348050772-27819-3-git-send-email-kishon@ti.com> <50EE8A89.4010801@ti.com>
Message-ID: <50EE921D.8020601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2013 10:31 AM, kishon wrote:
> Hi Benoit,
> 
> On Wednesday 19 September 2012 04:02 PM, Kishon Vijay Abraham I wrote:
>> Add omap-usb2 data node in omap4 device tree file. Since omap-usb2 is
>> connected to ocp2scp, omap-usb2 dt data is added as a child node
>> of ocp2scp.
>>
>> Acked-by: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> This patch is also missing in mainline :-(

Well, in that case this was done on purpose :-)

> 
> Thanks
> Kishon
> 
>> ---
>>   arch/arm/boot/dts/omap4.dtsi |    5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 4fbb9dc..28eaddc 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -303,6 +303,11 @@
>>               #size-cells = <1>;
>>               ranges;
>>               ti,hwmods = "ocp2scp_usb_phy";
>> +            usb2phy at 4a0ad080 {
>> +                compatible = "ti,omap-usb2";
>> +                reg = <0x4a0ad080 0x58>,
>> +                      <0x4a002300 0x4>; /* TO BE REMOVED: SCM */

Rob and I did not agree to use that temp hack in the case of DT, so you
were supposed to repost with a proper driver for the SCM part that
control the USB.

Regards,
Benoit
