From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 28 Aug 2013 12:19:43 +0200
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <521DCD33.2070008@gmail.com>
References: <20130828113459.48ecbb34@armhf>
	<521DCD33.2070008@gmail.com>
Message-ID: <20130828121943.1c8327ca@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian, Jean-Fran?ois,

On Wed, 28 Aug 2013 12:13:07 +0200, Sebastian Hesselbarth wrote:
> On 08/28/2013 11:34 AM, Jean-Francois Moine wrote:
> > This patch adds the nodes to instantiate the audio devices of the Dove
> > boards.
> >
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> >   arch/arm/boot/dts/dove.dtsi                  | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> > index 499abad..78227e2 100644
> > --- a/arch/arm/boot/dts/dove.dtsi
> > +++ b/arch/arm/boot/dts/dove.dtsi
> > @@ -573,6 +573,24 @@
> >   					phy-handle = <&ethphy>;
> >   				};
> >   			};
> > +
> > +			i2s0: audio-controller at b0000 {
> > +				compatible = "marvell,mvebu-audio";
> 
> [added Gregory to Cc]
> 
> Jean-Francois,
> 
> as Mark Brown already took the bindings patch for above generic
> compatible, how are we going to discriminate different
> implementations/features of Dove, Kirkwood, and Armada 370?

I agree that mvebu-audio is not a really good compatible string. It
should use the first SoC that introduced the IP block, so that if
future SOCs have variations, we can introduce separate compatible
strings.

So for now, the compatible string should be kirkwood-audio.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
