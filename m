From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 17 Sep 2015 22:56:56 +0800
Subject: [PATCH 2/2] arm64: dts: mt8173: add timer node
In-Reply-To: <55FAC570.8040307@arm.com>
References: <1442369095-1094-1-git-send-email-yingjoe.chen@mediatek.com>
 <1442369095-1094-2-git-send-email-yingjoe.chen@mediatek.com>
 <55FAC570.8040307@arm.com>
Message-ID: <1442501816.4784.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-09-17 at 14:51 +0100, Sudeep Holla wrote:
> 
> On 16/09/15 03:04, Yingjoe Chen wrote:
> > From: Daniel Kurtz <djkurtz@chromium.org>
> >
> > Add device node to enable GPT timer. This timer will be
> > used as sched clock source.
> >
> 
> Interesting any known issues with or advantage over the arch timers
> to prefer it as sched clock source. I see even arch timers are present
> in DT, hence the question. Or is it just a incorrect commit log ?
> 
> How does this get selected as sched clock source ? I don't see
> sched_clock_register in mtk_timer.c
> 
> To be clear, I am not against adding this timer support, but just want
> to know is it preferred for sched clock source ? if yes why ? better
> resolution ?

Hi Sudeep,

Thanks for your review.

I hit the send too soon and missed cover letter, please see:
http://lists.infradead.org/pipermail/linux-mediatek/2015-September/002303.html

The main reason to use GPT as sched clock is it won't stop during idle.


> > Change-Id: Idc4e3f0ee80b5c36cae6f0f2328f94aafcca1253
> 
> ^ Should be dropped
> 
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8173.dtsi | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > index d18ee42..d763803 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -238,6 +238,15 @@
> >   			reg = <0 0x10007000 0 0x100>;
> >   		};
> >
> > +		timer: timer at 10008000 {
> > +			compatible = "mediatek,mt8173-timer",
> 
> Missing documentation ? I am referring upstream and it might be in some 
> patches already queued perhaps ?

This is documented in
Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt.
Do you mean I should add "mediatek,mt8173-timer" to that file?

Joe.C
