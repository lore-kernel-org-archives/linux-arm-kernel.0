From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 3 Sep 2018 11:00:38 +0800
Subject: [PATCH 0/3] arm64: dts: allwinner: a64: pinmux cleanups
In-Reply-To: <20180828151140.7vc44czdlv4yhan2@flea>
References: <20180828100132.12975-1-wens@csie.org>
 <20180828151140.7vc44czdlv4yhan2@flea>
Message-ID: <CAGb2v651odpMn0LKYwP9WJjMZmzkBRyskaTWTaJ-YzJgB86EDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

n Tue, Aug 28, 2018 at 11:12 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Aug 28, 2018 at 06:01:29PM +0800, Chen-Yu Tsai wrote:
> > Hi,
> >
> > This series does some cleanup of the Allwinner A64 pinmux groups.
> >
> > The first addresses a limitation on the A64 where we have the eMMC's
> > DS in always muxed in. The DS pin is shared with SPI0's MISO, thereby
> > preventing SPI0 from being used. In this patch we split out the DS
> > pin into a separate group for boards that actually utilize it to
> > select on their own.
> >
> > The other two patches just rename pinmux group node names and labels
> > from <func>_pins_<[a-z]> to <func>_<pingroup/pin names>_pins. The latter
> > is the style we adopted later on, and is easier to know which pins they
> > correspond to, i.e. easier to review.
> >
> > Please have a look.
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Applied.

> > While I want to do some more cleanup, I realized that the label and/or
> > node names might be used by distro (Armbian comes to mind) or personal
> > device tree overlay files. Do we need to have these remain fixed? Do
> > we or can we provide a fallback? (Is that even possible?)
>
> I wouldn't worry too much about this. We broke it a number of times
> already, and we probably will in the future for other stuff, I'm not
> sure we have to provide any guarantee there, as long as the old,
> compiled, dt still works.

OK :)
