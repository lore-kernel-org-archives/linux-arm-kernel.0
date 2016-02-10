From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Feb 2016 19:02:04 +0000
Subject: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting
 cs-gpio
In-Reply-To: <878u2s2xym.fsf@eliezer.anholt.net>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-4-git-send-email-stephanolbrich@gmx.de>
 <87d1s54f7f.fsf@eliezer.anholt.net>
 <20160210080149.GQ13270@sirena.org.uk>
 <878u2s2xym.fsf@eliezer.anholt.net>
Message-ID: <20160210190204.GD13270@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 10:59:29AM -0800, Eric Anholt wrote:

> Oops, this makes more sense now.  Subject even mentioned gpio, and a
> GPIO CS must be getting set around the transfer_one call.  I'll be ready
> to send an r-b for a v2 with the speed update bug fixed (unless transfer
> speeds are guaranteed to be constant between a prepare and unprepare).

No guarantee that they'll not change, especially in a situation where we
have two devices on different speeds on a bus working at the same time.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160210/80c1d3df/attachment.sig>
