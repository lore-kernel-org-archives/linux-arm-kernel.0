From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Aug 2012 17:31:05 +0100
Subject: The curse of EPROBE_DEFER
Message-ID: <20120809163105.GU18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, so we have this wonderful new feature called EPROBE_DEFER.  I
had in the back of my mind while at the meetup in Prague where this
was discussed that it would cause problems... of the type I'm now
having, which is:

soc-audio soc-audio: ASoC machine CuBox-spdif should use snd_soc_register_card()
soc-audio soc-audio: Failed to register card
platform soc-audio: Driver soc-audio requests probe deferral

repeated many times in the kernel messages, but there's _zero_ clue
as to why, and unless I enable debugging in sound/soc through a kernel
rebuild, there's little chance of finding out.

This is idiotic, and fragile, and completely mad.  If we're going to
have EPROBE_DEFER at least have the curtesy to your users to say *why*
you're failing the probe, and *not* at the (by default) invisible debug
level.  I mean, saying that the probe failed but not saying *why* is
utterly stupid.
