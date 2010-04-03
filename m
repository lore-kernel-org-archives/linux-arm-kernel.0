From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Sat, 03 Apr 2010 10:31:33 +0200
Subject: [PATCH] dns323-setup.c: fix WARN() when booting
Message-ID: <87ljd5j5sq.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Since commit b2a731aa5cbca7e0252da75e16de7ae5feb1313a, dns323_init() is
setting the power led gpio direction with gpio_direction_output() but
doesn't request the gpio before (which is not permitted by the gpio
layer afaik). This behaviour is triggering a WARN() at boot time.

Tested-by: Christian Samsel <csamsel@gmxpro.de>
Cc: Martin Michlmayr <tbm@cyrius.com>
Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: led.patch
Type: text/x-diff
Size: 491 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100403/0dfe8253/attachment.bin>
