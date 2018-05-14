From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 14 May 2018 16:11:26 +0200
Subject: [PATCH v14 8/8] ASoC: sun4i-codec: Add Left Capture Select,
 Right Capture Select
In-Reply-To: <20180505124050.66f74999@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
 <20180502210800.1971-9-dannym@scratchpost.org>
 <20180503145408.yymk2ndt4sm2yt4i@flea>
 <20180505124050.66f74999@scratchpost.org>
Message-ID: <20180514141126.mv7iso2d4xrfnsax@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 05, 2018 at 12:40:50PM +0200, Danny Milosavljevic wrote:
> Hi Maxime,
> 
> On Thu, 3 May 2018 16:54:08 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> 
> > > +static const char * const sun4i_codec_capture_source[] = {
> > > +	"Line",
> > > +	"FM",
> > > +	"Mic1",
> > > +	"Mic2",
> > > +	"Mic1,Mic2",
> > > +	"Mic1+Mic2",
> > > +	"Output Mixer",
> > > +	"Line,Mic1",
> > > +};  
> > 
> > Shouldn't that be defined in a more generic way? As far as I know,
> > there's no way to tell what the difference between "Mic1,Mic2" and
> > "Mic1+Mic2" would be from the userspace.
> 
> Sounds good - but how?
> 
> Here, "Mic1,Mic2" means the left channel captured is Mic1 and the right
> channel captured is Mic2.
> 
> On the other hand, "Mic1+Mic2" means that the signals from Mic1 and
> Mic2 are added together and that is captured (both as left and as right).
> 
> "Mic1" means both the left channel and the right channel captured is
> from Mic1.  Likewise "Mic2".

Right, and my point isn't that it is difficult to understand or
remember once you get it, but that it's difficult to get it in the
first place, and that this convention is solely based on the one used
in the datasheet, which is an abstraction violation in itself.

I guess that's really up to Mark here, but one solution would be to
allow to couple the controls explicitly instead of relying solely on
the fact that they share the same controls array pointer.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180514/9e1abc0a/attachment-0001.sig>
