From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 3 Mar 2014 08:42:35 +0200
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <20140228162327.GT21483@n2100.arm.linux.org.uk>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
 <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>
 <20140228155937.GQ21483@n2100.arm.linux.org.uk> <5310B567.7040605@ti.com>
 <20140228162327.GT21483@n2100.arm.linux.org.uk>
Message-ID: <5314245B.803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/14 18:23, Russell King - ARM Linux wrote:

>> I guess the compatible string is the easiest way for differentation, at
>> least for the three main types, i.e. "dvi-d-connector" etc.
>>
>> "dvi-d-1l-connector" and "dvi-d-2l-connector" for the single/dual link?
>> That looks a bit funny.
> 
> I think that starts getting a tad messy:
> 
> 	dvi-a-connector
> 	dvi-d-1l-connector
> 	dvi-d-2l-connector
> 	dvi-i-1l-connector
> 	dvi-i-2l-connector

Yes, it's messy. Pondering this over the weekend, I think it makes sense
to have just one compatible string, as all those connectors are still
the same DVI connector, just different variations of the same.

> That's rather a lot of compatible strings.  Another possibility is:
> 
> 	compatible = "dvi-connector";
> 	analog;
> 	digital;
> 	single-link;
> 	dual-link;
> 
> I'm debating whether "-signalling" should be on the 2nd and 3rd (or...
> -signaling depending on how you prefer to spell that word.)  At least
> one of "analog" and/or "digital" must be specified, and if "digital"
> is specified, then exactly one of "single-link" or "dual-link" should
> be specified.
> 
> So, this would mean we end up with:
> 
> 	compatible = "dvi-connector";
> 	analog;
> 	digital;
> 	dual-link;
> 
> for a DVI-I dual-link connector.

Another option would be:

num-links = 2;

But I like your suggestion more. We could also optimize it, "digital" is
extra as both "single-link" and "dual-link" mean also digital. But... I
don't see much point in optimizing that way. So I agree with your
suggestion as is.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/8ac18169/attachment.sig>
