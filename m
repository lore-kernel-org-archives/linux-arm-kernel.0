From: eric@anholt.net (Eric Anholt)
Date: Wed, 28 Sep 2016 14:24:36 -0700
Subject: [PATCH v3 7/7] i2c: bcm2835: Add support for dynamic clock
In-Reply-To: <1475085056-5205-8-git-send-email-noralf@tronnes.org>
References: <1475085056-5205-1-git-send-email-noralf@tronnes.org>
 <1475085056-5205-8-git-send-email-noralf@tronnes.org>
Message-ID: <87r383g1kb.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Noralf Tr?nnes <noralf@tronnes.org> writes:

> Support a dynamic clock by reading the frequency and setting the
> divisor in the transfer function instead of during probe.

Is this fixing some particular case you could note in the commit
message?  As is, it makes me think that we should be using a notifier
for when the parent clock (that's the one I assume you're talking about
being dynamic) changes.  But maybe you're working around a variable VPU
clock being set by the firmware, because we don't have a notifier for
it?

I'm a bit worried because I think this is going to be pretty expensive
to be doing per transfer.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160928/074f1585/attachment.sig>
