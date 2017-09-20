From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 20 Sep 2017 14:14:13 -0700
Subject: [PATCH v4 2/5] dt-bindings: input: Add document bindings for
 mtk-pmic-keys
In-Reply-To: <20170920205301.v6gpmhll4pdpuyxv@rob-hp-laptop>
References: <1505635252-27716-1-git-send-email-chen.zhong@mediatek.com>
 <1505635252-27716-3-git-send-email-chen.zhong@mediatek.com>
 <20170920205301.v6gpmhll4pdpuyxv@rob-hp-laptop>
Message-ID: <20170920211413.GA36148@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 03:53:01PM -0500, Rob Herring wrote:
> On Sun, Sep 17, 2017 at 04:00:49PM +0800, Chen Zhong wrote:
> > This patch adds the device tree binding documentation for the MediaTek
> > pmic keys found on PMIC MT6397/MT6323.
> > 
> > Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> > ---
> >  .../devicetree/bindings/input/mtk-pmic-keys.txt    |   41 ++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> > new file mode 100644
> > index 0000000..fd48ff7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> > @@ -0,0 +1,41 @@
> > +MediaTek MT6397/MT6323 PMIC Keys Device Driver
> > +
> > +There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
> > +and homekey. The key functions are defined as the subnode of the function
> > +node provided by MT6397/MT6323 PMIC that is being defined as one kind
> > +of Muti-Function Device (MFD)
> > +
> > +For MT6397/MT6323 MFD bindings see:
> > +Documentation/devicetree/bindings/mfd/mt6397.txt
> > +
> > +Required properties:
> > +- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
> > +- linux,keycodes: Specifies the numeric keycode values to
> > +	be used for reporting keys presses. The array can
> > +	contain up to 2 entries.
> > +
> > +Optional Properties:
> > +- mediatek,wakeup-keys: Specifies each key can be used as a wakeup source
> > +	or not. This can be customized depends on board design.
> 
> I think this should be a common property if we're going to put into DT. 
> Something like "wakeup-scancodes" to be clear the values are the raw 
> scancodes. Alternatively, we could list Linux keycodes instead with 
> something like "linux,wakeup-keycodes".

Should we go the gpio-keys way and describe keys as sub-nodes, possibly
using address as index?

		mt6397keys: mt6397keys {
			...

			power at 0 {
				linux,code = <116>;
				wakeup-source;
			};

			home at 1 {
				linux,code = <...>;
			};
		};

Thanks.

-- 
Dmitry
