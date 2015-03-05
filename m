From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Mar 2015 19:28:17 +0100
Subject: [PATCH v2 1/4] i2c: sunxi: Add Reduced Serial Bus (RSB) support
In-Reply-To: <20150304172710.GA884@katana>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-2-git-send-email-wens@csie.org>
 <20150304172710.GA884@katana>
Message-ID: <20150305182817.GB4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Wed, Mar 04, 2015 at 06:27:11PM +0100, Wolfram Sang wrote:
> On Mon, Mar 02, 2015 at 04:24:43PM +0800, Chen-Yu Tsai wrote:
> > The RSB controller looks like an SMBus controller which only supports byte
> > and word data transfers. It can also do double-word data transfers, but the
> > I2C subsystem does not support this, nor have we seen devices using this.
> > 
> > The RSB differs from standard SMBus protocol on several aspects:
> > - it uses addresses set at runtime to address slaves. Runtime addresses
> >   are sent to slaves using their 12bit hardware addresses. Up to 15
> >   runtime addresses are available.
> > - it adds a parity bit every 8bits of data and address for read and
> >   write accesses; this replaces the ack bit
> > - only one read access is required to read a byte (instead of a write
> >   followed by a read access in standard SMBus protocol)
> > - there's no Ack bit after each read access
> > 
> > This means this bus cannot be used to interface with standard SMBus
> > devices (known devices supporting this interface are the AXP223, AXP806,
> > AXP809 PMICs and the AC100 codec/RTC). However the RSB protocol is an
> > extension of P2WI, which was close enough to SMBus to be integrated into
> > the I2C subsystem in commit 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull
> > 2 Wire Interface) controller support").
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> I don't have the bandwidth for a full review right now. However, I
> already wanted to tell you guys that my gut feeling is that this
> protocol is quite far away from I2C. P2WI was already at the edge.
> Maybe there is a better place for such custom stuff? I dunno yet.

That's unfortunate, especially since it looks closer to SPI than what
P2WI even was.

What would be your suggestion?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/ca4afefe/attachment.sig>
