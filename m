From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 3 Mar 2014 09:23:05 +0200
Subject: [PATCH 4/9] Doc/DT: Add DT binding documentation for HDMI
 Connector
In-Reply-To: <CAMuHMdVpT2Y-KQO46o=zbRSgqgx2mbBsPjGgoTDDwwfCOxUCmw@mail.gmail.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<1393590016-9361-5-git-send-email-tomi.valkeinen@ti.com>	<20140228160612.GR21483@n2100.arm.linux.org.uk>	<5310B609.1010105@ti.com>	<20140228163431.GV21483@n2100.arm.linux.org.uk>
 <CAMuHMdVpT2Y-KQO46o=zbRSgqgx2mbBsPjGgoTDDwwfCOxUCmw@mail.gmail.com>
Message-ID: <53142DD9.4020709@ti.com>
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

Right. And then there are the HDMI versions, and things like HDMI
Ethernet Channel. After looking at these a bit, I don't think the HDMI
connector needs any of those (hdmi version, eth) defined.

So...

	compatible = "hdmi-connector";
	type = "a";

Or

	compatible = "hdmi-connector";
	type-a;

I don't right away see any big pro with either one compared to the other.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/9622c09d/attachment.sig>
