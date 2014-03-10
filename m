From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 10 Mar 2014 14:23:21 +0200
Subject: [PATCH v5 1/2] video: ARM CLCD: Add DT support
In-Reply-To: <1394453382.3853.6.camel@hornet>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>	
 <53184C2E.3000807@ti.com> <1394119431.4160.84.camel@hornet>	
 <5319AF00.5030602@ti.com> <1394453382.3853.6.camel@hornet>
Message-ID: <531DAEB9.3020502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/14 14:09, Pawel Moll wrote:

>> Note that the same DT bindings you add here should also work for the DRM
>> driver in the future. So, in fact, the question is extended to: will the
>> fbdev 
> 
> No, I don't think so. It's a end of line for it, I believe. From my
> personal point of view the main goal is to fill the last gap between DT
> and non-DT support on one of the Versatile Express boards - CLCD works
> fine when booted with ATAGs, doesn't work when booted with DT. It looks
> bad.

The DT describes the hardware, and there should be only one description
of it, no matter what the used SW is. I see compatible = "arm,pl111" in
the dts. PL111 is the LCD controller, right? What will the DRM driver
use, then, if the "arm,pl111" DT data is designed to work only for the
fbdev?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/b28a4f0a/attachment.sig>
