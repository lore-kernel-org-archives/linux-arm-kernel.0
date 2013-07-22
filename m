From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 22 Jul 2013 12:40:13 +0300
Subject: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
In-Reply-To: <20130708142103.GX21614@n2100.arm.linux.org.uk>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191751.468.89202.stgit@localhost>
 <20130520095447.GR21614@n2100.arm.linux.org.uk>
 <20130706131057.GU21614@n2100.arm.linux.org.uk>
 <20130706133627.GV21614@n2100.arm.linux.org.uk>
 <20130708093410.GT5523@atomide.com>
 <20130708142103.GX21614@n2100.arm.linux.org.uk>
Message-ID: <51ECFDFD.60102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/13 17:21, Russell King - ARM Linux wrote:

> Also looks like the nonfunctional video stuff is even more nonfunctional
> than usual:
> 
> omapdss DSI error: can't get VDDS_DSI regulator
> omapdss HDMI error: can't get VDDA_HDMI_DAC regulator

Those should be followed by "...requests probe deferral", and the driver
is probed again later.

The log
http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=946
shows "taal display2: panel revision e3.83.7d" which hints that the
panel (and DSS) was initialized properly.

Those error prints should probably be tuned down a bit now that the
driver uses probe deferral.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130722/b1fe83e3/attachment.sig>
