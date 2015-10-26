From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 26 Oct 2015 11:23:44 +0100
Subject: [PATCH 1/3] dt-bindings: add document of mediatek efuse driver
In-Reply-To: <562DF8BE.4060205@linaro.org>
References: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
 <1444984751-4572-2-git-send-email-andrew-ct.chen@mediatek.com>
 <562DF8BE.4060205@linaro.org>
Message-ID: <20151026102344.GD25308@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 09:56:14AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 16/10/15 09:39, andrew-ct.chen at mediatek.com wrote:
> >From: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> >
> >Add Mediatek MT8173 EFUSE Devicetree binding file
> >
> >Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> 
> Looks good to me, minor comment below.
> 
> Will queue this for v4.5 once v4.4-rc1 is released.
> 
> 
> >---
> >  .../devicetree/bindings/nvmem/mtk-efuse.txt        | 36 ++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> >
> >diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> >new file mode 100644
> >index 0000000..92edc3d
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> >@@ -0,0 +1,36 @@
> >+= Mediatek MTK-EFUSE device tree bindings =
> >+
> >+This binding is intended to represent MTK-EFUSE which is found in most Mediatek SOCs.
> >+
> >+Required properties:
> >+- compatible: should be "mediatek,mt8173-efuse" or "mediatek,mt8135-efuse"
> 
> Can we make the compatible more generic for mediatek socs? Like
> "mediatek,efuse"  Or are they different in each SOC?

While we can add an additional "mediatek,efuse" compatible we should
always add the most specific compatible first. Otherwise we cannot
differentiate between SoCs later without changing the device tree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
