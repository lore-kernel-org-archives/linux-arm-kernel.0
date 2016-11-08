From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 8 Nov 2016 21:39:07 +0100
Subject: [PATCH 3/3] ARM: gr8: evb: Add i2s codec
In-Reply-To: <CAGb2v6557B5dooERbKc709Hbrzb3vP8eoSj3nh6rKek7UwrgEQ@mail.gmail.com>
References: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
 <4d99da31af41b26d9109113e19223ee8b88f76ae.1478524066.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65bzWJpEnmwk89Qkn+_QawcPtpCJdA+90Dgc68FLRNQqw@mail.gmail.com>
 <20161108074414.vvnjj7aa26sloi2f@lukather>
 <CAGb2v6557B5dooERbKc709Hbrzb3vP8eoSj3nh6rKek7UwrgEQ@mail.gmail.com>
Message-ID: <20161108203907.wylvt3xvhx3mi3tg@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 03:57:48PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 8, 2016 at 3:44 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Nov 07, 2016 at 10:11:45PM +0800, Chen-Yu Tsai wrote:
> >> On Mon, Nov 7, 2016 at 9:08 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > The GR8-EVB comes with a wm8978 codec connected to the i2s bus.
> >> >
> >> > Add a card in order to have it working
> >> >
> >> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >> > ---
> >> >  arch/arm/boot/dts/ntc-gr8-evb.dts | 14 ++++++++++++++
> >> >  1 file changed, 14 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/arch/arm/boot/dts/ntc-gr8-evb.dts b/arch/arm/boot/dts/ntc-gr8-evb.dts
> >> > index 12b4317a4383..5291e425caf9 100644
> >> > --- a/arch/arm/boot/dts/ntc-gr8-evb.dts
> >> > +++ b/arch/arm/boot/dts/ntc-gr8-evb.dts
> >> > @@ -76,6 +76,20 @@
> >> >                 default-brightness-level = <8>;
> >> >         };
> >> >
> >> > +       i2s {
> >>
> >> "sound" might be a better node name? The I2S controllers are also
> >> named "i2s".
> >
> > I know, but we also had the codec and SPDIF on this board, so sound
> > was too generic to be meaningful I guess. I don't really care about
> > the name though, if you have any suggestion...
> 
> Well people seem to use "sound" for the sound card nodes...
> 
> What about "sound-analog" for this one, and "sound-spdif" for the
> SPDIF simple card? Or "analog-sound" and "spdif-sound" if that looks
> better.

sound-analog works for me. I'll either fix it in the v2, or while
applying.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161108/68ade2b6/attachment.sig>
