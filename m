From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Jun 2018 19:22:57 -0300
Subject: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
In-Reply-To: <638457fd-85da-8fec-d146-517c43f71813@denx.de>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
Message-ID: <CAOMZO5DJju6oBRLakkTx4np7w9nMwPm6TMkGGYjbMLUPDUugYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 6:36 PM, Marek Vasut <marex@denx.de> wrote:

> Having two drivers in the kernel with different set of bugs is always bad.

Sure, but breaking dtb's is also bad.

Can the mxsfb driver be modified to handle the old style bindings?

The IPU drm driver is capable of handling both the old style where the
display timing is passed in dts and the new drm style.

For example:

arch/arm/boot/dts/imx6qdl-sabresd.dtsi uses the drm style binding
arch/arm/boot/dts/imx6qdl-sabreauto.dtsi uses the old style of passing
the display timings in dts

Both formats are accepted by the ipu drm driver.

Can't mxsfb drm driver support both? Then we don't need to worry about
breaking dtb's and could safely remove the mxs fbdev driver.
