From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 31 Jul 2018 07:51:17 +0800
Subject: [PATCH v3.1 08/10] dt-bindings: sun4i-drm: add HDMI VCC supply
 property for sun8i-dw-hdmi
In-Reply-To: <20180730231244.GA3966@rob-hp-laptop>
References: <20180726171257.6688-1-icenowy@aosc.io>
 <20180726171257.6688-9-icenowy@aosc.io> <20180730231244.GA3966@rob-hp-laptop>
Message-ID: <F275EA55-B791-4EDC-8796-DB79E95D7008@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?31? GMT+08:00 ??7:12:44, Rob Herring <robh@kernel.org> ??:
>On Fri, Jul 27, 2018 at 01:12:55AM +0800, Icenowy Zheng wrote:
>> Allwiner SoCs with DesignWare HDMI controller all come with a "HVCC"
>> pin, which is the VCC of HDMI part.
>> 
>> Add a supply property to specify HVCC's regulator in the device tree.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v3.1:
>> - New patch.
>> 
>>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3
>+++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git
>a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> index fdb8fb29033f..cb4769913e89 100644
>> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> @@ -97,6 +97,9 @@ Required properties:
>>      first port should be the input endpoint. The second should be
>the
>>      output, usually to an HDMI connector.
>>  
>> +Optional properties:
>> +  - hdmi-supply: the VCC power supply of the controller
>
>"hdmi" doesn't sound like the name of the supply. "hvcc" or just "vcc" 
>would be more appropriate.

Okay. In original versions it used to be "hvcc-supply", and
I will pick the name again.

>
>Rob
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
