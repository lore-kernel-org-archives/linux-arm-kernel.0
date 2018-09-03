From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 3 Sep 2018 11:05:52 +0800
Subject: [PATCH 0/3] arm64: dts: allwinner: h5: Add device tree for
 Bananapi M2 Plus H5
In-Reply-To: <20180831101742.3ybvf6d3refft454@flea>
References: <20180830080926.15027-1-wens@csie.org>
 <20180831101742.3ybvf6d3refft454@flea>
Message-ID: <CAGb2v65+p-m90wj9MP9SP7x8xGUT2YLwJ-aiDgo9CW85YFSySg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 6:17 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Aug 30, 2018 at 04:09:23PM +0800, Chen-Yu Tsai wrote:
> > Hi,
> >
> > Allwinner's H5 SoC is pin compatible with the H3 SoC. As such, some
> > vendors produce H3 and H5 variants for the same device. Such is the
> > case with Libre Computer's ALL-H3-CC, and the Bananapi M2 Plus.
> >
> > This series follows that of the ALL-H3-CC, splitting out a common
> > board dtsi, and then two SoC-specific dts files that include the
> > SoC level and common board dtsi's, as well as putting in the board
> > name. The first patch is a minor fix that I think should be done
> > before the migration.
> >
> > Please have a look.
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> > Also, on a related matter, Bananapi recently released revision v1.2
> > of the M2 Plus. The original commercially available version was v1.1.
> > v1.2 adds a GPIO control that can change the CPU cores' supply voltage
> > between 1.1V and 1.3V. Do we want two extra dts files for this? Put
> > them in the existing dts files regardless? Or let people handle this
> > via overlays?
>
> If that the sole change, I'd be inclined to merge it as a separate DT
> for that particular version. Is there any way to detect it at runtime?

It seems there isn't. The pin in both new and old revisions have an
external pull-up with the same value, so it isn't possible to detect
whether the pin is used or not. And there are no other changes between
the two.

ChenYu
