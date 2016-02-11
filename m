From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Feb 2016 12:27:36 +0000
Subject: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting
 cs-gpio
In-Reply-To: <2743238.b2UJKq0efN@chaos-desktop>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <878u2s2xym.fsf@eliezer.anholt.net>
 <20160210190204.GD13270@sirena.org.uk>
 <2743238.b2UJKq0efN@chaos-desktop>
Message-ID: <20160211122736.GH13270@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 09:26:05PM +0100, Stephan Olbrich wrote:
> Am Wednesday 10 February 2016, 19:02:04 schrieb Mark Brown:

> > No guarantee that they'll not change, especially in a situation where we
> > have two devices on different speeds on a bus working at the same time.

> Are you saying, that between a prepare and unprepare there could be transfers 
> for another device? Then all the clock setting couldn't be done in prepare 
> either.
> Apart from that, if two transfers in the same message are not guarantied to 
> have the same speed, this still needs to be fixed. I'll roll a v2.

There are two prepares, I don't know which you're talking about.  The
most common is prepare_transfer_hardware() which is used to power up the
hardware and may have many transfers for many devices before it is
reversed.  The other is prepare_message() which is called once per
message.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/21540ab2/attachment-0001.sig>
