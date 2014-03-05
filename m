From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 5 Mar 2014 10:42:36 +0200
Subject: [PATCH 4/9] Doc/DT: Add DT binding documentation for HDMI
 Connector
In-Reply-To: <CAMuHMdVpT2Y-KQO46o=zbRSgqgx2mbBsPjGgoTDDwwfCOxUCmw@mail.gmail.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<1393590016-9361-5-git-send-email-tomi.valkeinen@ti.com>	<20140228160612.GR21483@n2100.arm.linux.org.uk>	<5310B609.1010105@ti.com>	<20140228163431.GV21483@n2100.arm.linux.org.uk>
 <CAMuHMdVpT2Y-KQO46o=zbRSgqgx2mbBsPjGgoTDDwwfCOxUCmw@mail.gmail.com>
Message-ID: <5316E37C.4070400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/14 20:58, Geert Uytterhoeven wrote:
> On Fri, Feb 28, 2014 at 5:34 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> There's actually three HDMI connectors:
>>
>>   All three connectors carry all required HDMI signals, including a TMDS
>>   link. The Type B connector is slightly larger and carries a second TMDS
>>   link, which is necessary to support very high resolution displays using
>>   dual link. The Type C connector carries the same signals as the Type A
>>   but is more compact and intended for mobile applications.
>>
>> So, Type C and Type A are electrically the same.
> 
> There's also D (e.g. on BeagleBone Black) and E:
> 
> http://en.wikipedia.org/wiki/HDMI#Connectors
> 
> Electrically they seem to be the same as A/C.

I made the following change compared to the posted version.

 Tomi

@@ -3,6 +3,7 @@ HDMI Connector

 Required properties:
 - compatible: "hdmi-connector"
+- type: the HDMI connector type: "a", "b", "c", "d" or "e"

 Optional properties:
 - label: a symbolic name for the connector
@@ -17,6 +18,8 @@ hdmi0: connector at 1 {
        compatible = "hdmi-connector";
        label = "hdmi";

+       type = "a";
+
        hdmi_connector_in: endpoint {
                remote-endpoint = <&tpd12s015_out>;
        };


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/ce46cb06/attachment.sig>
