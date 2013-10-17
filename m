From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Oct 2013 15:10:03 +0100
Subject: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
In-Reply-To: <525FEB7A.5040406@metafoo.de>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <525FD4C7.3050806@tabi.org> <525FD65B.3040004@metafoo.de>
 <525FE48B.7020709@tabi.org> <525FE728.90403@metafoo.de>
 <525FE815.1040300@tabi.org> <525FEB7A.5040406@metafoo.de>
Message-ID: <20131017141003.GO2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 03:51:54PM +0200, Lars-Peter Clausen wrote:
> On 10/17/2013 03:37 PM, Timur Tabi wrote:

> > I understand that, but I'm trying to figure out why of_iomap() is okay for
> > hundreds of other drivers, but not this one.  I've used it dozens of times
> > myself, without ever worrying about overlapping regions.

> The driver would work fine with just of_iomap(). But the resource range
> check comes basically for free and it does help to catch errors, so I'd
> recommend on using it rather than not using it.

There's also the fact that it's a devm_ function which means less error
handling code that we can break which is nice.  There's probably a case
for an improved OF helper here...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131017/204d832d/attachment.sig>
