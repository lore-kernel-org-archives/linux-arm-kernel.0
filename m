From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 9 Jul 2014 17:37:20 +0100
Subject: [PATCH v3 1/5] phy: miphy365x: Add Device Tree bindings for the
 MiPHY365x
In-Reply-To: <CAG374jBLq8YShOakBJtf2U47wuKGYNM7vSTn4PjzHsvjaYjmNQ@mail.gmail.com>
References: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
 <1404906074-31992-2-git-send-email-lee.jones@linaro.org>
 <CAG374jBLq8YShOakBJtf2U47wuKGYNM7vSTn4PjzHsvjaYjmNQ@mail.gmail.com>
Message-ID: <20140709163720.GN2635@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 09 Jul 2014, Gabriel Fernandez wrote:
> On 9 July 2014 13:41, Lee Jones <lee.jones@linaro.org> wrote:
> > The MiPHY365x is a Generic PHY which can serve various SATA or PCIe
> > devices. It has 2 ports which it can use for either; both SATA, both
> > PCIe or one of each in any configuration.
> >
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../devicetree/bindings/phy/phy-miphy365x.txt      | 76 ++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-miphy365x.txt

[...]

> > +Specifying phy control of devices
> > +=================================
> > +
> > +Device nodes should specify the configuration required in their "phys"
> > +property, containing a phandle to the phy port node and a device type.
> > +
> > +Example:
> > +
> > +#include <dt-bindings/phy/phy-miphy365x.h>
> > +
> > +       sata0: sata at fe380000 {
> > +               ...
> > +               phys      = <&miphy365x_phy MIPHY_TYPE_SATA>;
> > +               ...
> 
> In this example you select the type (SATA) but I don't understand how
> do you select
> the port (phy_port0 or phy_port1)

Right, historical typo.  Will send a v+1 as a reply, so it's easy for
Kishon to collect when he applies next week.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
