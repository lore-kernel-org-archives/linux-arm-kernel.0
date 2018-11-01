From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu, 01 Nov 2018 21:33:26 +0100
Subject: [PATCH v2 0/7] BL035-RGB-002 3.5" LCD sunxi DRM support
In-Reply-To: <20181101200045.6078-1-contact@paulk.fr>
References: <20181101200045.6078-1-contact@paulk.fr>
Message-ID: <1e9757dd782ffb187efd26582881db019609493c.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le jeudi 01 novembre 2018 ? 21:00 +0100, Paul Kocialkowski a ?crit :
> The series adds support for the BL035-RGB-002 LCD panel and the required
> device-tree bindings for using it on the BananaPi M1.
> 
> Only the changes related to the DRM driver and the panel are submitted
> for merge, which does not include the two final commits.
> 
> Changes since v1:
> * Used the full name of the panel for dt bindings;
> * Removed helper to match flags in order to only retrieve the connector
>   once, as it was already done.
> * Made the bus flags checking possible without a panel;

I forgot to mention that the last patch (not for merge) was untested.

> Paul Kocialkowski (7):
>   drm/sun4i: tcon: Pass encoder instead of using panel for RGB setup
>   drm/sun4i: tcon: Support an active-low DE signal with RGB interface
>   dt-bindings: Add vendor prefix for LeMaker
>   dt-bindings: Add bindings for the LeMaker BL035-RGB-002 LCD panel
>   drm/panel: simple: Add support for the LeMaker BL035-RGB-002 3.5" LCD
>   ARM: dts: sun7i: Add pinmux configuration for LCD0 RGB888 pins
>   ARM: dts: sun7i-a20-bananapi: Add bindings for the LeMaker 3.5" LCD
> 
>  .../display/panel/lemaker,bl035-rgb-002.txt   |  7 ++
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  arch/arm/boot/dts/sun7i-a20-bananapi.dts      | 89 +++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi              | 11 +++
>  drivers/gpu/drm/panel/panel-simple.c          | 27 ++++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.c            | 29 +++---
>  drivers/gpu/drm/sun4i/sun4i_tcon.h            |  1 +
>  7 files changed, 151 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lemaker,bl035-rgb-002.txt
> 
-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181101/6d543954/attachment-0001.sig>
