From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 18 Mar 2014 08:33:55 +0200
Subject: [PATCH 6/9] Doc/DT: Add DT binding documentation for MIPI DSI
 CM Panel
In-Reply-To: <4670830.fkS1noPxcd@avalon>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-7-git-send-email-tomi.valkeinen@ti.com>
 <4670830.fkS1noPxcd@avalon>
Message-ID: <5327E8D3.5010907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/14 16:22, Laurent Pinchart wrote:

>> +Example
>> +-------
>> +
>> +lcd0: display {
>> +	compatible = "tpo,taal", "panel-dsi-cm";
>> +	label = "lcd0";
>> +
>> +	gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;	/* 102, reset */
> 
> If the panel uses a TE GPIO but no reset GPIO, do you plan to express this 
> with a "hole" for the reset GPIO ? e.g. something like
> 
> 	gpios = <0>, <&gpio4 6 GPIO_ACTIVE_HIGH>;

Yes.

> Wouldn't it be better to split the gpios property into "reset-gpios" and "te-
> gpios" ?

Yes, I can change it. I don't have a strong preference.

I've gotten similar comments for other bindings also, so I guess the
preferred way is to use named "-gpios" properties for everything except
the case where you really have multiple gpios with the same purpose?

The gpio binding documentation doesn't give much guidance on this.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/d3f51e70/attachment.sig>
