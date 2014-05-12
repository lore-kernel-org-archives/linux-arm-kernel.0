From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 12 May 2014 17:44:18 +0300
Subject: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
In-Reply-To: <20140512143934.GC31772@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
 <536C860E.1000501@ti.com> <20140509143703.GA17814@atomide.com>
 <5370B222.7050702@ti.com> <20140512143934.GC31772@atomide.com>
Message-ID: <5370DE42.2060607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/14 17:39, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140512 04:36]:
>> On 09/05/14 17:37, Tony Lindgren wrote:
>>>
>>> This is just the 3730-evm with the Sharp VGA panel mentioned in
>>> this series.
>>
>> Hmm, well, those both look fine. The fck is well below the maximum,
>> which is somewhere around 170MHz-180MHz. The lck/pck ratio is higher
>> with this patch, but that should affect the GFX overlay.
>>
>> So you're just booting, and there are no applications that use the
>> framebuffer? And there is no rotation or such configured?
> 
> Right. The rotation is set to 3 though.

Hmm, that's probably the issue then. VRFB rotation is very heavy on the
memory bandwidth, and is generally a very easy way to get sync lost errors.

My opinion is that VRFB should only be used when you know your system
will handle it fine with the clock rates and bandwidth usage you have
for your use cases.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140512/42f6404f/attachment.sig>
