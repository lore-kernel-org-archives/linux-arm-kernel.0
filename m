From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Jan 2017 22:56:36 +0100
Subject: [PATCH v2 0/8] ASoC: sunxi: Add support for audio codec in
 A23/H3 SoCs
In-Reply-To: <CAGb2v65mo2g90QX6DMpw4dN4=fjccP2kp-NAbUPBzXYTtF8kMg@mail.gmail.com>
References: <20161125123442.28410-1-wens@csie.org>
 <CAGb2v65mo2g90QX6DMpw4dN4=fjccP2kp-NAbUPBzXYTtF8kMg@mail.gmail.com>
Message-ID: <20170108215636.v3swmhetvzzce4r2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2017 at 03:00:40AM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> On Fri, Nov 25, 2016 at 8:34 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> > Hi everyone,
> >
> > This is v2 of my Allwinner A23 and H3 audio codec support series.
> >
> > Changes since v1:
> >
> >   - Use DEFINE_RES_MEM for the analog path controls block resources.
> >   - Added Rob's ack.
> >
> > This series adds support for the audio codec found in Allwinner A23 and
> > H3 SoCs. The design and data paths are similar to the audio codec found
> > in earlier SoCs such as the A31. The analog audio paths are symmetrical
> > with left/right channels and down-mix selectors for mono differential
> > output.
> >
> > What deviates from previous SoCs is that the analog path controls have
> > been moved to a separate control bus, accessed through a message box
> > like register interface in the PRCM block. This necessitates writing
> > a separate component driver for it, which is then tied into the sound
> > card as an ASoC auxiliary device.
> >
> > Patch 1 adds the analog path controls block to the sun6i-prcm driver as
> > a sub-device, for the A23. The H3 currently does not use the PRCM driver.
> >
> > Patch 2 adds PCM and card support for the A23 codec to the sun4i-codec
> > driver.
> >
> > Patch 3 adds a device node for the analog path controls block to the A23
> > dtsi.
> >
> > Patch 4 adds a device node for the audio codec, and the phandle for the
> > analog path controls block to the A23 dtsi.
> >
> > Patch 5 enables the audio codec for the A23 Q8 tablets. On these tablets
> > the headphone output is driven in DC coupled, or "direct drive", mode.
> >
> > Patch 6 adds PCM and card support for the H3 codec to the sun4i-codec
> > driver.
> >
> > Patch 7 adds device nodes for the audio codec and analog path controls
> > block to the H3 dtsi.
> >
> > Patch 8 enables the audio codec on the Orange Pi PC. The audio output
> > jack on the board is tied to the line out pins on the SoC.
> 
> All the driver bits are in. Can you pick up the dts patches?

I just did.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170108/da80dea7/attachment.sig>
