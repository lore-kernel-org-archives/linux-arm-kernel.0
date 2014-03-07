From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 7 Mar 2014 13:35:28 +0200
Subject: [PATCH v5 1/2] video: ARM CLCD: Add DT support
In-Reply-To: <1394119431.4160.84.camel@hornet>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>	
 <53184C2E.3000807@ti.com> <1394119431.4160.84.camel@hornet>
Message-ID: <5319AF00.5030602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/14 17:23, Pawel Moll wrote:
> On Thu, 2014-03-06 at 10:21 +0000, Tomi Valkeinen wrote:
>> Is this an old HW, and presumably there won't be new users for it? If
>> yes, this is probably fine. 
> 
> There is a DRM driver in the works, actually...
> 
>> If not, you might want to look at the video
>> ports and endpoints, which is used by at least three not-yet-merged series:
>>
>> [PATCHv3 00/41] OMAPDSS: DT support v3
>> [PATCH v5 00/11] imx-drm dt bindings
>> [RFC PATCH v2 00/21] Add DSI display support for Exynos based boards
>>
>> Using bindings like that would be more future proof, even if the current
>> driver doesn't use them.
> 
> ... and this makes me try to get out of its way. In other words, I fully
> agree with you, but I don't think this applies to this particular patch,
> as I'm not even trying to represent the display pipeline. The (optional)

Right, you are not, at the moment. My point was, if the driver is
extended later to support pipelines, or common panel/encoder drivers,
you (most likely) need to have similar bindings than the other people use.

Note that the same DT bindings you add here should also work for the DRM
driver in the future. So, in fact, the question is extended to: will the
fbdev or drm driver support common panels/encoders?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/91a78354/attachment-0001.sig>
