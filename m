From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Aug 2016 11:41:06 +0100
Subject: ASoC: sun4i-codec: playback stall and I/O error with DAPM paths
 all disabled
In-Reply-To: <20160822091815.GE7104@lukather>
References: <CAGb2v66X2BhEM4X+zQHUFB-wpHuBQ4xc8ztfYFuKADnY0b-gaQ@mail.gmail.com>
 <20160815114211.GI9347@sirena.org.uk>
 <CAGb2v66diZMuxddK9jM5-RbOZGOF5EK_jgxxkWV-ad6WHCNd9Q@mail.gmail.com>
 <20160822091815.GE7104@lukather>
Message-ID: <20160822104106.GK22076@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 11:18:15AM +0200, Maxime Ripard wrote:
> On Tue, Aug 16, 2016 at 12:45:39PM +0800, wens Tsai wrote:

> > Ok. So I guess one solution would be to move the mute controls out of
> > DAPM, and maybe change some other mux like paths into actual muxes, so
> > there's at least one usable path at all times.

> I'm not sure that's even a requirement. IIRC, but Mark might correct
> me, you just need to expose whatever the reset state is.

Yes, this results in some inconvenience but avoids problems caused by
configuration changes for one board affecting another adversely - if we
just go with the hardware defaults it's something fixed externally.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/7057a38a/attachment.sig>
