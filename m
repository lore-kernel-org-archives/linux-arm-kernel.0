From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 10 Mar 2014 12:32:18 +0200
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <1394201859.16309.14.camel@paszta.hi.pengutronix.de>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>		<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>		<20140228155937.GQ21483@n2100.arm.linux.org.uk>	<5310B567.7040605@ti.com>		<20140228162327.GT21483@n2100.arm.linux.org.uk>	<5316E31F.9050308@ti.com>	
 <CAMuHMdWVSfKrudBhE7FW-ZWBvMOLWjrQZvn1qZUfRt_H+P7A2w@mail.gmail.com>	
 <53183730.5060205@ti.com>
 <1394201859.16309.14.camel@paszta.hi.pengutronix.de>
Message-ID: <531D94B2.4040304@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/14 16:17, Philipp Zabel wrote:
> Hi,
> 
> Am Donnerstag, den 06.03.2014, 10:52 +0200 schrieb Tomi Valkeinen:

>> analog;
>> digital-single-link;
>> digital-dual-link;
>>
>> My reasoning to the format I chose was basically that when a connector
>> supports 'digital', it contains TMDS clock and TMDS data for link 1.
>> Adding dual link to that adds only TMDS data for link 2, so the second
>> data link is kind of an additional feature, marked with a flag.
>>
>> Not a very big argument, and I'm fine with other format suggestions.
> 
> I'd prefer the analog / digital / dual-link variant for aesthetic
> reasons. But looking at other connector types, I wonder if this should
> be generalized even more:
> 
> For HDMI/DVI (digital) single-link means one clock pair and 3 TMDS data
> pairs, dual-link means one clock pair and 6 data pairs.
> 
> On LVDS connectors, there usually are one clock pair and three (18-bit)
> or four (24-bit) LVDS data pairs, in dual channel configuration two
> clock pairs and 6 or 8 data pairs are used.
> 
> For DisplayPort there is no separate clock pair, but 1 to 4 data pairs,
> and MIPI DSI again has one clock pair and a one or more data pairs.
> 
> There are already optional endpoint configuration properties
> 'data-lanes' and 'clock-lanes' for MIPI CSI-2 defined in
> Documentation/devicetree/bindings/media/video-interfaces.txt.
> Could/should this be aligned with the same?

Hmm. Well, at least for HDMI and DP we anyway need the connector type,
which tells the form factor, and it also tells the TMDS details. So, we
could define the lanes in a common way, but we'd still need extra
information.

For MIPI DSI and (I believe) LVDS, we don't need connectors. Connectors,
as described in this binding, are meant for standard hotpluggable
connectors to which you can connect any device that has that same connector.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/6e78afa8/attachment.sig>
