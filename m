From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 15:15:29 +0100
Subject: [PATCH 00/77] ARM: dts: sunxi: Cleanup DTC warnings
In-Reply-To: <CAGb2v65zbQ7HGAGdgbQQWjhqC81-E6-_UVO8KVan25kx84g+Dw@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v65zbQ7HGAGdgbQQWjhqC81-E6-_UVO8KVan25kx84g+Dw@mail.gmail.com>
Message-ID: <20181128141529.vg6hu3jo6mqsk6my@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 09:25:00PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Here is a (rather big) series that fixes most of our DTC warnings. The
> > number of warnings when compiled with W=1 after applying this series
> > goes from 3343 to 23, 21 of them being the same warning, which would
> > be fixed by the current series adding support for the Cedrus driver on
> > H3/H5.
> >
> > The two remaining one are on the A80 and would require some change in
> > the clock driver. Given how little activity there is on the A80, we
> > can expect it to not happen in a near future, but I can live with two
> > warnings.
> >
> > I also took the occasion to convert all the arm SoCs to our newer
> > syntax and rules when applicable.
> >
> > Let me know what you think,
> > Maxime
> 
> This series looks pretty good. Only bits I'm concerned about are the
> removal of "reg = <0>" for the display pipeline. This is likely to
> cause the backend and mixer drivers to not bind.

I've dropped them for now.

> Also, I think we can get rid of the pull-ups for the USB ID pin. All
> the reference designs show an external pull-up for that.

Yeah, I was wondering that too, but I ended up being conservative
about it. I'll send a patch.

> As for the GPIO LED drive current bits, I'd really like an alternative.
> I need something like that for the Orange Pi Lite 2 (H6).

There was some effort a few months ago, maybe we should ping Linus
about this.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/90452766/attachment.sig>
