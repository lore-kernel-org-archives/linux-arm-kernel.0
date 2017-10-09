From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Mon, 9 Oct 2017 10:43:47 +0800
Subject: [PATCH 10/12] dt-bindings: usb: mtu3: add a optional property
 to disable u3ports
In-Reply-To: <20171005223117.23pvuzhg2th4byz3@rob-hp-laptop>
References: <fe8df8503f602586bcea4b1598eb09678b1525e3.1506509658.git.chunfeng.yun@mediatek.com>
 <fd4890851d8233635b334a0fad7742a58e53bc7a.1506509659.git.chunfeng.yun@mediatek.com>
 <20171005223117.23pvuzhg2th4byz3@rob-hp-laptop>
Message-ID: <1507517027.17567.42.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-10-05 at 17:31 -0500, Rob Herring wrote:
> On Thu, Sep 28, 2017 at 08:17:18AM +0800, Chunfeng Yun wrote:
> > Add a new optional property to disable u3ports
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  .../devicetree/bindings/usb/mediatek,mtu3.txt      |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > index 49f5476..7c611d1 100644
> > --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> > @@ -44,6 +44,8 @@ Optional properties:
> >   - mediatek,enable-wakeup : supports ip sleep wakeup used by host mode
> >   - mediatek,syscon-wakeup : phandle to syscon used to access USB wakeup
> >  	control register, it depends on "mediatek,enable-wakeup".
> > + - mediatek,u3p-dis-msk : mask to disable u3ports, bit0 for u3port0,
> > +	bit1 for u3port1, ... etc;
> 
> How does this relate to the XHCI change? Same comment applies.

There is a upper layer called IPPC (IP Power and Clock interface) shared
by device IP and host IP (xHCI) to control power and clock of each port.
So I can disable or enable xCHI's ports by IPPC indirectly.
