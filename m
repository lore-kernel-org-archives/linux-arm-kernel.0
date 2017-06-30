From: broonie@kernel.org (Mark Brown)
Date: Fri, 30 Jun 2017 12:51:50 +0100
Subject: [PATCHv2 9/9] spi: spidev: add Aardvark to device tree
 compatibility list
In-Reply-To: <67764839-889b-e398-16eb-de583d82cbf3@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
 <1498578321-13980-10-git-send-email-amelie.delaunay@st.com>
 <20170628185445.fsnqs2tlqqeqzl57@sirena.org.uk>
 <67764839-889b-e398-16eb-de583d82cbf3@st.com>
Message-ID: <20170630115150.zea5iaoih4alqibm@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 02:58:43PM +0200, Amelie DELAUNAY wrote:
> On 06/28/2017 08:54 PM, Mark Brown wrote:

> > What does this device actually do and why is spidev a sensible fit for
> > it?

> This device is actually a debugging tool [1] which can work on SPI bus (and
> also I2C). Connected via USB on a PC, it can either acts as an SPI master or
> SPI slave and it can transmit/receive serial data using SPI protocol.
> Polarity, Phase, Bit Order, Frequency can be configured. So this tool is
> really useful during SPI driver development to troubleshoot. And that's why
> spidev driver totally fit for it when used as an SPI slave, for the reason
> described in spidev Documentation: "Developing simple protocols used to talk
> to" Aardvark "acting as SPI slaves, which you may need to change quite
> often".

This doesn't seem like something that should be in DT, it's a tool used
to implement or emulate other things and is no more specific than spidev
itself is.  Whatever it is implementing or emulating should be in DT
instead.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170630/05df9ffb/attachment.sig>
