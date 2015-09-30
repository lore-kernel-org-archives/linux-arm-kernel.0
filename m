From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 19:03:03 +0100
Subject: [PATCH 1/6] Revert "regulator: core: Handle full constraints
 systems when resolving supplies"
In-Reply-To: <1443621946-8712-2-git-send-email-s.hauer@pengutronix.de>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
 <1443621946-8712-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150930180303.GM15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 04:05:41PM +0200, Sascha Hauer wrote:
> This reverts commit 9f7e25edb1575a6d2363dc003f9cc09d840657e2.
> 
> When a regulator A is registered and is supplied by regulator B which is
> not yet registered then a regulator_get on regulator A will set the As
> supply to the dummy regulator. This is not correct, we should return
> -EPROBE_DEFER instead as done without this patch.

What makes you say this is not correct?  In a system with fully
specified supplies if we fail to resolve the supply we know that no
supply will ever appear and so substitute in the dummy on the assumption
that there is a supply with no software control.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/823ee91b/attachment.sig>
