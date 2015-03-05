From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Mar 2015 23:08:01 +0100
Subject: [PATCH v2 1/4] i2c: sunxi: Add Reduced Serial Bus (RSB) support
In-Reply-To: <20150305184044.GA881@katana>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-2-git-send-email-wens@csie.org>
 <20150304172710.GA884@katana> <20150305182817.GB4911@lukather>
 <20150305184044.GA881@katana>
Message-ID: <20150305220801.GE4522@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 07:40:44PM +0100, Wolfram Sang wrote:
> 
> > > I don't have the bandwidth for a full review right now. However, I
> > > already wanted to tell you guys that my gut feeling is that this
> > > protocol is quite far away from I2C. P2WI was already at the edge.
> > > Maybe there is a better place for such custom stuff? I dunno yet.
> > 
> > That's unfortunate, especially since it looks closer to SPI than what
> > P2WI even was.
> 
> SPI? I assume you mean I2C. Can you elaborate your reasoning?

Yeah, I obviously meant I2C, sorry.

P2WI had no address. It was a single-device bus. However, the way it
communicated with the device was very close to I2C, apart from a
parity bit instead of the ACK.

>From that regard, RSB is a multiple device bus, using addresses, just
like I2C. The way it communicates is basically the one used by P2WI.

So really, it just is more I2C-alike than P2WI has ever been.

> > What would be your suggestion?
> 
> Let me quote:
> 
> "I don't have the bandwidth for a full review right now... I dunno
> yet."

Good thing that we are not talking about a full review then, but more
a philosophical discussion.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/9cc459e3/attachment.sig>
