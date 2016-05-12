From: eric@anholt.net (Eric Anholt)
Date: Thu, 12 May 2016 11:15:27 -0700
Subject: [PATCH 0/4] add minimal bcm2835-sdram driver
In-Reply-To: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
References: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <87twi39m80.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> As the sdram clock is a critical clock to the system
> the minimal bcm2835-sdram driver claims (and enables)
> this clock and also exposes the corresponding sdram
> registers via debugfs.

I don't think this is a good solution to the problem you are trying to
work around.  You're relying on the fact that this driver gets
successfully probed before a driver that would -EPROBE_DEFER on a
sibling clock, which is not a guarantee.

Let's please continue the debugging of clock management on linux-clk.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160512/1f9f9b34/attachment.sig>
