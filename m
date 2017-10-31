From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Oct 2017 11:19:28 +0100
Subject: [PATCH] ASoC: sun4i-codec: fixed 32bit audio capture support for
 H3/H2+
In-Reply-To: <20171030121603.GB12678@andrea-laptop>
References: <20171029094048.GA5295@ubuntu>
 <20171030085542.udrw2s7pcznb75rl@flea>
 <20171030121603.GB12678@andrea-laptop>
Message-ID: <20171031101928.bztbv2vqugb7cvbg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 01:16:03PM +0100, Andrea Bondavalli wrote:
> Hello Maxime, everyone,
> 
> see comments inline.
> 
> On Mon, Oct 30, 2017 at 09:55:42AM +0100, Maxime Ripard wrote:
> > On Sun, Oct 29, 2017 at 02:41:01AM -0700, Andrea Bondavalli wrote:
> > > Fixed support for 32bit audio capture for Allwinner H3/H2+ SoC
> > > 
> > > Signed-off-by: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
> > 
> > A more detailed commit log would be welcome.
> > 
> > What are the issues involved would be the more valuable information,
> > and then how you'ring fixing it and why would be great.
> > 
> 
> H3 audio codec supports 16 and 24 bits capture formats (same for the playback).
> Switching between these two modes can be achieved by using the RX_SAMPLE_BITS (bit 6)
> of the AC_ADC_FIFOC register (offset 0x10) of the audio codec. 
> The RX_FIFO_MODE (bit 24) register must also be set accordingly to have
> the desired RX FIFO output mode.
> 
> The current implementation declares support for 16bit and 32bit (with a 
> resolution of 24bit) capture formats but the 32bit implementation is broken 
> because the RX_SAMPLE_BITS and the RX_FIFO_MODE bits are not set correctly and 
> in addition to this the DMA bus transfer width is left to 2 bytes instead of 
> 4 bytes causing invalid captures whose durating is double than the expected period.
> 
> The following patch sets the H3 audio codec registers properly when a
> 24/32bit capture is requested.
> Similar approach was already implemented for the audio playback part.

Thanks.

Can you put that in your commit log and resend the patch?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171031/9e6cb033/attachment.sig>
