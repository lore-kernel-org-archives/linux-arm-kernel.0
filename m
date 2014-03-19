From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 19 Mar 2014 10:11:30 +0200
Subject: [PATCHv2 4/8] Doc/DT: Add DT binding documentation for HDMI
 Connector
In-Reply-To: <1395216233.4300.6.camel@paszta.hi.pengutronix.de>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>	
 <1395130547-18633-5-git-send-email-tomi.valkeinen@ti.com>	
 <1395132234.4134.1.camel@paszta.hi.pengutronix.de>	
 <1664822.t9aWz7hh4g@avalon>
 <1395216233.4300.6.camel@paszta.hi.pengutronix.de>
Message-ID: <53295132.6000003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/14 10:03, Philipp Zabel wrote:

>>> Geert's comment also applies to all other connector types. These can be
>>> input connectors, too.
>>
>> We might not need to define all the properties required by input connectors 
>> now, but we need to make sure that future extensions will be backward-
>> compatible. I don't see a problem in making the connector DT bindings depend 
>> on the direction as long as the direction is specified in the DT node, either 
>> explicitly or implicitly.
>>
>> An obvious solution would be to have separate "hdmi-input-connector" and 
>> "hdmi-output-connector" compatible strings but I don't like that, as there's 
>> no difference in the HDMI connector itself, only in the usage.
> 
> I don't think this is necessary, either. I just meant the wording for
> the video port should leave the direction unspecified. I imagine
> somebody somewhere will connect a HDMI connector to a mux so that it can
> be either input or output.

I don't disagree, but I think it's better to change the wording when
someone has a working setup and can try it. These bindings have been
designed only with video output in mind, and I'd rather have them
constrained to that purpose for now.

One reason for keeping them output only is that when someone wants to
use these for capture, he needs to change the binding docs, and it'll
gather more attention than just using the bindings in a board's dts.

That said, we should take care to make the bindings so that nothing
prevents their use for capture (which I think they allow in their
current form).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140319/d4352c4b/attachment.sig>
