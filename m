From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Aug 2014 15:46:46 +0100
Subject: io-domain voltages as regulators?
In-Reply-To: <3923586.SsVg941346@diego>
References: <3923586.SsVg941346@diego>
Message-ID: <20140804144646.GR30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 12:18:40AM +0200, Heiko St?bner wrote:

> As this sound like exactly the thing I'm trying to solve, is handling this via 
> a regulator the correct general way?

My first thought is that it seems sensible if it's used as a regulated
supply in a context where just a plain regulator might be used like
MMC/SDIO type things.  If it's only setting logic levels for I/O pins
but isn't something that's being dynamically managed or really visible
to software (it's just a board design thing) then it might not be worth
it but if it might be controlled by changing an external regulator then
using the same API seems like it might be sensible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140804/237364a3/attachment.sig>
