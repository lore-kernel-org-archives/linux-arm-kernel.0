From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Sat, 5 May 2018 12:40:50 +0200
Subject: [PATCH v14 8/8] ASoC: sun4i-codec: Add Left Capture Select,
 Right Capture Select
In-Reply-To: <20180503145408.yymk2ndt4sm2yt4i@flea>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-9-dannym@scratchpost.org>
 <20180503145408.yymk2ndt4sm2yt4i@flea>
Message-ID: <20180505124050.66f74999@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thu, 3 May 2018 16:54:08 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> > +static const char * const sun4i_codec_capture_source[] = {
> > +	"Line",
> > +	"FM",
> > +	"Mic1",
> > +	"Mic2",
> > +	"Mic1,Mic2",
> > +	"Mic1+Mic2",
> > +	"Output Mixer",
> > +	"Line,Mic1",
> > +};  
> 
> Shouldn't that be defined in a more generic way? As far as I know,
> there's no way to tell what the difference between "Mic1,Mic2" and
> "Mic1+Mic2" would be from the userspace.

Sounds good - but how?

Here, "Mic1,Mic2" means the left channel captured is Mic1 and the right
channel captured is Mic2.

On the other hand, "Mic1+Mic2" means that the signals from Mic1 and
Mic2 are added together and that is captured (both as left and as right).

"Mic1" means both the left channel and the right channel captured is
from Mic1.  Likewise "Mic2".
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180505/01a96e0c/attachment.sig>
