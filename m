From: mporter@linaro.org (Matt Porter)
Date: Tue, 21 Jan 2014 20:35:12 -0500
Subject: [PATCH] pinctrl: Rename Broadcom Capri pinctrl driver
In-Reply-To: <CAOesGMj7wXJ+DfXzk0U1pusKqZShq+KJdPY8hh=Ffj7KDti4_Q@mail.gmail.com>
References: <1390343886-25852-1-git-send-email-syin@broadcom.com>
 <CAOesGMj7wXJ+DfXzk0U1pusKqZShq+KJdPY8hh=Ffj7KDti4_Q@mail.gmail.com>
Message-ID: <20140122013512.GT31176@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 04:59:35PM -0800, Olof Johansson wrote:
> Hi,
> 
> 
> On Tue, Jan 21, 2014 at 2:38 PM, Sherman Yin <syin@broadcom.com> wrote:
> > To be consistent with other Broadcom drivers, the Broadcom Capri pinctrl
> > driver and its related CONFIG option are renamed to bcm281xx.
> >
> > Devicetree compatible string and binding documentation use
> > "brcm,bcm11351-pinctrl" to match the machine binding here:
> > Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
> >
> > This driver supports pinctrl on BCM11130, BCM11140, BCM11351, BCM28145
> > and BCM28155 SoCs.
> >
> > Signed-off-by: Sherman Yin <syin@broadcom.com>
> > Reviewed-by: Matt Porter <mporter@linaro.org>
> > ---
> >  ...capri-pinctrl.txt => brcm,bcm11351-pinctrl.txt} |    8 +-
> >  arch/arm/boot/dts/bcm11351.dtsi                    |    2 +-
> >  arch/arm/configs/bcm_defconfig                     |    2 +-
> >  drivers/pinctrl/Kconfig                            |    8 +-
> >  drivers/pinctrl/Makefile                           |    2 +-
> >  .../{pinctrl-capri.c => pinctrl-bcm281xx.c}        | 1521 ++++++++++----------
> >  6 files changed, 775 insertions(+), 768 deletions(-)
> >  rename Documentation/devicetree/bindings/pinctrl/{brcm,capri-pinctrl.txt => brcm,bcm11351-pinctrl.txt} (98%)
> >  rename drivers/pinctrl/{pinctrl-capri.c => pinctrl-bcm281xx.c} (25%)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,capri-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
> > similarity index 98%
> > rename from Documentation/devicetree/bindings/pinctrl/brcm,capri-pinctrl.txt
> > rename to Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
> > index 9e9e9ef..c119deb 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/brcm,capri-pinctrl.txt
> > +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
> > @@ -1,4 +1,4 @@
> > -Broadcom Capri Pin Controller
> > +Broadcom BCM281xx Pin Controller
> >
> >  This is a pin controller for the Broadcom BCM281xx SoC family, which includes
> >  BCM11130, BCM11140, BCM11351, BCM28145, and BCM28155 SoCs.
> > @@ -7,14 +7,14 @@ BCM11130, BCM11140, BCM11351, BCM28145, and BCM28155 SoCs.
> >
> >  Required Properties:
> >
> > -- compatible:  Must be "brcm,capri-pinctrl".
> > +- compatible:  Must be "brcm,bcm11351-pinctrl"
> 
> Since the original binding is queued for 3.14 (I believe?), if this
> rename isn't merged for 3.14 then you will still need to accept the
> old compatible string (binding). You can document it as deprecated,
> but the driver needs to still probe with it.

Linus had mentioned that he could take a rename in 3.14-rc for this
driver which is really what we had in mind here. Since the binding
doesn't become stable until 3.14 is actually released I was under the
impression that this is ok without keeping a deprecated compatible
string. I notice that Tomasz had comments about this type of situation
in http://www.spinics.net/lists/devicetree/msg18010.html

-Matt
