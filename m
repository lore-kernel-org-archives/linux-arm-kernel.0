From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Dec 2014 11:49:49 +0000
Subject: OMAP 4430 SDP: rather sick with recent kernels
In-Reply-To: <20141218101618.GJ11502@n2100.arm.linux.org.uk>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
 <20141217185155.GI11502@n2100.arm.linux.org.uk>
 <5491F0B6.4090904@ti.com>
 <20141218101618.GJ11502@n2100.arm.linux.org.uk>
Message-ID: <20141218114949.GY11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 10:16:18AM +0000, Russell King - ARM Linux wrote:

> So that doesn't work - but importantly, it does point towards a
> possible culpret - snd_soc_of_parse_audio_routing().

> This is obvious when you stop and think about what it's doing, this is
> truely where this bug lies, and it /is/ in generic ASoC code.

> The problem is that this function doesn't consider the implications of
> deferred probing.  Let's see what happens if we defer, and re-do the
> ABE initialisation, including calling this function:

Right, spot on - I'll send a revert for that upstream.  Thanks for
tracking this down.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141218/d29f4884/attachment.sig>
