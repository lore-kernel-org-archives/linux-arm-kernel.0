From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 Oct 2014 15:45:27 +0100
Subject: [PATCH 06/12] ARM: tegra: Add memory controller support for
 Tegra20
In-Reply-To: <CAASgrz3Z2vW0L+u5kju9bAh-R4PnreMnhoGaKY_UwSTGFcBshA@mail.gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-6-git-send-email-thierry.reding@gmail.com>
 <CAASgrz3Z2vW0L+u5kju9bAh-R4PnreMnhoGaKY_UwSTGFcBshA@mail.gmail.com>
Message-ID: <20141030144525.GC20072@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 17, 2014 at 10:43:56AM -0700, David Riley wrote:
> Hi Thierry,
> 
> On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Collapses the old memory-controller and IOMMU device tree nodes into a
> > single node to more accurately describe the hardware.
> >
> > Note that this is an incompatible change, but while a GART driver has
> > existed for a few years it has never been used to do any translations.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  arch/arm/boot/dts/tegra20.dtsi | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> > index 3b374c49d04d..a195c1975f3c 100644
> > --- a/arch/arm/boot/dts/tegra20.dtsi
> > +++ b/arch/arm/boot/dts/tegra20.dtsi
> > @@ -538,15 +538,14 @@
> >
> >         memory-controller at 7000f000 {
> >                 compatible = "nvidia,tegra20-mc";
> > -               reg = <0x7000f000 0x024
> > -                      0x7000f03c 0x3c4>;
> > +               reg = <0x7000f000 0x00000400   /* controller registers */
> > +                      0x58000000 0x02000000>; /* GART aperture */
> 
> Aren't these bindings supposed to be stable?  The tegra20-mc driver
> isn't modified.

You're right in that this particular patch should be deferred until the
Tegra20 driver has been updated.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/99dc4245/attachment.sig>
