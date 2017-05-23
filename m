From: jun.gao@mediatek.com (Jun Gao)
Date: Tue, 23 May 2017 11:34:01 +0800
Subject: [RESEND PATCH v3 1/2] dt-bindings: i2c: Add Mediatek MT2701 i2c
 binding
In-Reply-To: <4111ffc2-0a25-0811-fbd3-401649431315@gmail.com>
References: <1489029185-21447-1-git-send-email-jun.gao@mediatek.com>
 <1489029185-21447-2-git-send-email-jun.gao@mediatek.com>
 <20170322090543.sxacnddn2o7stjnq@ninjato>
 <1490694612.18582.11.camel@mhfsdcap03> <20170328192258.GA4525@katana>
 <4111ffc2-0a25-0811-fbd3-401649431315@gmail.com>
Message-ID: <1495510441.930.7.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-05-10 at 12:35 +0200, Matthias Brugger wrote:
> 
> On 28/03/17 21:22, Wolfram Sang wrote:
> > On Tue, Mar 28, 2017 at 05:50:12PM +0800, Jun Gao wrote:
> >> On Wed, 2017-03-22 at 10:05 +0100, Wolfram Sang wrote:
> >>> On Thu, Mar 09, 2017 at 11:13:04AM +0800, Jun Gao wrote:
> >>>> From: Jun Gao <jun.gao@mediatek.com>
> >>>>
> >>>> Add MT2701 i2c binding to i2c-mt6577.txt and there is no need to
> >>>> modify i2c driver.
> >>>>
> >>>> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> >>>
> >>> There is still the issue which Matthias Brugger pointed out on January,
> >>> 24th: you need to describe the fallback compatibles.
> >>>
> >>
> >> IMHO the value under compatible are just inputs which can be accepted.
> >> It's little strange to add fallback information in binding. Some other
> >> bindings do not describe so detailedly.
> >> Is it OK to make binding as minimum standard?
> >> If we describe it very detailedly, we will have to modify binding if
> >> there are some changes for mt2701.
> > 
> > My reading of the below is that I could simply use "mediatek,mt2701-i2c"
> > as compatible and things will work. But it won't, we don't have that in
> > the driver IIRC. So, we need a fallback for that to work.
> > 
> >> Rob, could you give some suggestions?  Thanks!
> > 
> > Would be welcome, yes. I lost track what the preferred solution is.
> > 
> 
> We will need to define the fallback binding for each SoC.
> As example take the rockchip mmc:
> http://elixir.free-electrons.com/linux/latest/source/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> 
> Regards,
> Matthias
> 

Hi Rob,

There is no such requirement for other components.
Could you give us some suggestions? 
Thanks!


> >>
> >>>> ---
> >>>>   .../devicetree/bindings/i2c/i2c-mt6577.txt         |   11 ++++++-----
> >>>>   1 file changed, 6 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> >>>> index 0ce6fa3..27dbbf9 100644
> >>>> --- a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> >>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
> >>>> @@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
> >>>>   
> >>>>   Required properties:
> >>>>     - compatible: value should be either of the following.
> >>>> -      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
> >>>> -      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
> >>>> -      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
> >>>> -      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
> >>>> -      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
> >>>> +	"mediatek,mt2701-i2c"
> >>>> +	"mediatek,mt6577-i2c"
> >>>> +	"mediatek,mt6589-i2c"
> >>>> +	"mediatek,mt8127-i2c"
> >>>> +	"mediatek,mt8135-i2c"
> >>>> +	"mediatek,mt8173-i2c"
> >>>>     - reg: physical base address of the controller and dma base, length of memory
> >>>>       mapped region.
> >>>>     - interrupts: interrupt number to the cpu.
> >>>> -- 
> >>>> 1.7.9.5
> >>>>
> >>
> >>
