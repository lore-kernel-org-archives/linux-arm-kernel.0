From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Jun 2013 14:25:34 -0400
Subject: [GIT PULL 1/2] ARM: mvebu: dt changes for v3.11 (round 6!)
In-Reply-To: <201306211958.00637.arnd@arndb.de>
References: <20130621164611.GT31667@titan.lakedaemon.net>
 <201306211958.00637.arnd@arndb.de>
Message-ID: <20130621182534.GV31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 07:58:00PM +0200, Arnd Bergmann wrote:
> On Friday 21 June 2013, Jason Cooper wrote:
> > Arnd, Olof,
> > 
> > Here's the last stragglers for v3.11.  Nothing too traumatic :)
> > 
> > This does cause a merge conflict in kirkwood.dtsi with my
> > mvebu/pcie_kirkwood branch.  The resolution is to keep the changes in
> > this branch.
> > 
> > 
> > The following changes since commit 918f8f309643978b9e761f39af8962a7388d332d:
> > 
> >   ARM: Kirkwood: ts219: Enable second PCIe port in DT. (2013-06-11 16:02:08 +0000)
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/users/jcooper/linux.git tags/dt-3.11-6
> > 
> > for you to fetch changes up to 01db527e657d6cf646c6e6f059ad41e7023a25e7:
> > 
> >   ARM: Kirkwood: Fix the internal register ranges translation (2013-06-21 15:38:20 +0000)
> > 
> > ----------------------------------------------------------------
> > mvebu dt changes for v3.11 (round 6)
> > 
> >  - mvebu
> >     - mini-PCIe connectors on Armada 370 RD
> > 
> >  - kirkwood
> >     - correct internal register ranges translation
> > 
> > ----------------------------------------------------------------
> > Ezequiel Garcia (1):
> >       ARM: Kirkwood: Fix the internal register ranges translation
> > 
> > Thomas Petazzoni (1):
> >       arm: mvebu: enable mini-PCIe connectors on Armada 370 RD
> > 
> >  arch/arm/boot/dts/armada-370-rd.dts | 16 ++++++++++++++++
> >  arch/arm/boot/dts/kirkwood.dtsi     |  5 +++--
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> 
> Pulled into next/dt, thanks!
> 
> I got a non-obvious conflict that I resolved like this:
> 
> 
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@@ -30,8 -30,8 +30,9 @@@
>   
>         ocp at f1000000 {
>                 compatible = "simple-bus";
> -               ranges = <0x00000000 0xf1000000 0x4000000
> +               ranges = <0x00000000 0xf1000000 0x0100000


>  +                        0xe0000000 0xe0000000 0x8100000 /* PCIE */

good catch!  Looks like I need to redo my resolution in mvebu/for-next
:)

> +                         0xf4000000 0xf4000000 0x0000400
>                           0xf5000000 0xf5000000 0x0000400>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;

thx,

Jason.
