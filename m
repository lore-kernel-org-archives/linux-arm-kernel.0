From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Aug 2014 22:27:57 +0100
Subject: [PATCH 6/6] ARM: dts: Add tps65090 FETs constraints
In-Reply-To: <53EA61B9.2070805@collabora.co.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-7-git-send-email-javier.martinez@collabora.co.uk>
 <20140812172552.GU17528@sirena.org.uk>
 <53EA61B9.2070805@collabora.co.uk>
Message-ID: <20140812212757.GY17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 08:49:29PM +0200, Javier Martinez Canillas wrote:

> So, is adding these voltages ranges (the design limits) in the Peach Pit DTS
> file directly an acceptable solution? Basically what my previous patch [0] did.

> That matches what is in the board schematic so I assume that it's safe to use
> these voltage ranges for that machine. If so I'll drop this series and repost
> that patch fixing the typo error and commit message pointed by Doug that were
> already addressed in $subject.

Well, I think the question is if you understand where those numbers come
from and if they make sense.  I've not seen the schematic for the board
so I can't comment but it is quite unusual to see ranges listed for so
many supplies, for things like SD it's obviously normal but things like
video_mid are a bit more surprising.  Does anything actually vary those
voltages?

The change where you fix up the supply mappings still makes sense of
course.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140812/07d469ba/attachment.sig>
