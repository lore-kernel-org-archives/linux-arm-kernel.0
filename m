From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 16 May 2012 09:51:07 +0300
Subject: [PATCH 2/4] ARM: dt: tegra20.dtsi: Add Memory Controller(MC) nodes
In-Reply-To: <CAOesGMiPvw72006zpSGLBNi-C12MTc_w2QmOPg6YTfXMW+ZSkQ@mail.gmail.com>
References: <1336635764-30597-1-git-send-email-hdoyu@nvidia.com>
 <1336635764-30597-2-git-send-email-hdoyu@nvidia.com>
 <CAOesGMiPvw72006zpSGLBNi-C12MTc_w2QmOPg6YTfXMW+ZSkQ@mail.gmail.com>
Message-ID: <20120516095107.3510cb39d0f9cd2527e0bf1e@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, 16 May 2012 08:35:02 +0200
Olof Johansson <olof@lixom.net> wrote:

> Hi,
> 
> Tiny drive-by nit pick.
> 
> On Thu, May 10, 2012 at 12:42 AM, Hiroshi DOYU <hdoyu@nvidia.com> wrote:
> > Add Tegra MC(Memory Controller) nodes for tegra20.dtsi.
> >
> > Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
> > ---
> > ?arch/arm/boot/dts/tegra20.dtsi | ? ?7 +++++++
> > ?1 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> > index 24129fb..548b42e 100644
> > --- a/arch/arm/boot/dts/tegra20.dtsi
> > +++ b/arch/arm/boot/dts/tegra20.dtsi
> > @@ -211,5 +211,12 @@
> > ? ? ? ? ? ? ? ?compatible = "nvidia,tegra20-ahb";
> > ? ? ? ? ? ? ? ?reg = <0x6000c004 0x10c>; /* AHB Arbitration + Gizmo Controller */
> > ? ? ? ?};
> > +
> > + ? ? ? mc {
> 
> It's common to use a more plain english name here, so
> "memory-controller" would be a good name.

Agree. Seems to be common as below. Fix patches follows, which can be squashed if possible.

$% grep memory-controller arch/arm/boot/dts/*
arch/arm/boot/dts/prima2-cb.dts:                        memory-controller at 90000000 {
arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts:    memory-controller at 2b0a0000 {
arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts:    memory-controller at 7ffd0000 {
arch/arm/boot/dts/vexpress-v2p-ca5s.dts:        memory-controller at 2a150000 {
arch/arm/boot/dts/vexpress-v2p-ca5s.dts:        memory-controller at 2a190000 {
arch/arm/boot/dts/vexpress-v2p-ca9.dts: memory-controller at 100e0000 {
arch/arm/boot/dts/vexpress-v2p-ca9.dts: memory-controller at 100e1000 {
