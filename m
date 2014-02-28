From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 28 Feb 2014 18:12:23 +0200
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <20140228155937.GQ21483@n2100.arm.linux.org.uk>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
 <20140228155937.GQ21483@n2100.arm.linux.org.uk>
Message-ID: <5310B567.7040605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/14 17:59, Russell King - ARM Linux wrote:

>> +dvi0: connector at 0 {
>> +	compatible = "dvi-connector";
>> +	label = "dvi";
>> +
>> +	i2c-bus = <&i2c3>;
>> +
>> +	dvi_connector_in: endpoint {
>> +		remote-endpoint = <&tfp410_out>;
>> +	};
>> +};
> 
> This looks far too simplistic.  There are different classes of DVI
> connector - there is:
> 
> DVI A - analogue only
> DVI D - digital only (single and dual link)
> DVI I - both (single and dual digital link)
> 
> DRM at least makes a distinction between these three classes, and this
> disctinction is part of the user API.  How would a display system know
> which kind of DVI connector is wired up on the board from this DT
> description?

Yes, I think that's a valid change. But do we also need to specify
single/dual link, in addition to the three types?

I guess the compatible string is the easiest way for differentation, at
least for the three main types, i.e. "dvi-d-connector" etc.

"dvi-d-1l-connector" and "dvi-d-2l-connector" for the single/dual link?
That looks a bit funny.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/e3be1e68/attachment.sig>
