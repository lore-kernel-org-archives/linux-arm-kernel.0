From: jnair@caviumnetworks.com (Jayachandran C)
Date: Thu, 9 Feb 2017 19:05:23 +0000
Subject: [PATCH v3 4/5] dt-bindings: arm64 ARCH_THUNDER2 platform
 documentation
In-Reply-To: <CAK8P3a07eo0htv_y6H_aHvAaeo5two3vQTaySuFXpG+dzYguUQ@mail.gmail.com>
References: <1486502399-2950-1-git-send-email-jnair@caviumnetworks.com>
 <1486502399-2950-5-git-send-email-jnair@caviumnetworks.com>
 <CAL_Jsq+i2evzVnQKf3qYMYJVZ=ecdSQObGy8CMn7aMoxBi_PTg@mail.gmail.com>
 <20170208053234.GA3102@localhost>
 <CAK8P3a07eo0htv_y6H_aHvAaeo5two3vQTaySuFXpG+dzYguUQ@mail.gmail.com>
Message-ID: <20170209190523.GA6791@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 09:42:38AM +0100, Arnd Bergmann wrote:
> On Wed, Feb 8, 2017 at 6:32 AM, Jayachandran C <jnair@caviumnetworks.com> wrote:
> > On Tue, Feb 07, 2017 at 04:35:24PM -0600, Rob Herring wrote:
> >> On Tue, Feb 7, 2017 at 3:19 PM, Jayachandran C <jnair@caviumnetworks.com> wrote:
> >> > diff --git a/Documentation/devicetree/bindings/arm/cavium-thunder2.txt b/Documentation/devicetree/bindings/arm/cavium-thunder2.txt
> >> > new file mode 100644
> >> > index 0000000..82276a2
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/arm/cavium-thunder2.txt
> >> > @@ -0,0 +1,5 @@
> >> > +Cavium Thunder2 Family device tree bindings
> >> > +-------------------------------------------
> >> > +
> >> > +Boards with Cavium ThunderX2 CN99XX shall have the root property:
> >> > +  compatible = "cavium,thunder-99xx";
> >>
> >> Is it ThunderX2 or Thunder2? What happened to "CN" in the compatible
> >> string. There's a lot of inconsistencies here.
> >
> > I have followed the exiting Thunder naming as well as general DT
> > conventions, Basically:
> >
> > Platform - ARCH_THUNDER2  (for ThunderX2 CN99XX, ARCH_THUNDER is
> >            for ThunderX CN8?XX)
> 
> The platform name is fine, we don't care too much about that as it is
> easily changed
> if necessary.
> 
> > Core - cavium,thunder2 (ThunderX2 cpu core, "cavium,thunder" is ThunderX core)
> > Board/SoC - cavium,thunder-99xx (for ThunderX2, "cavium,thunder-88xx"
> >           is existing ThunderX board)
> >
> > Thunder2 because it is based on the next generation Thunder core, and
> > processor family is ThunderX2 CN99XX.
> >
> > I had thought thru other possibilities as well, this seems the best I
> > could come up with.
> 
> We should really avoid having the 'xx' placeholder in there but instead put
> actual chip names in the compatible string, preferably the real ID such as
> "cn8890" for the older chip. I see that we got it wrong for thunder-88xx.dts,
> but that is no reason to duplicate the mistake.

Ok. Looks like 1,2,5 of the patchset is already applied. Thanks!

I will follow up with v4 of 3,4 with a better ID.

JC.
