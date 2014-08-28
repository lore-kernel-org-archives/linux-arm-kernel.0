From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Aug 2014 18:12:28 +0100
Subject: [PATCH v2 6/6] ARM: dts: hix5hd2: add wdg node
In-Reply-To: <53FEF4A7.2040001@gmail.com>
References: <1409204060-9223-1-git-send-email-zhangfei.gao@linaro.org>
 <1409204060-9223-7-git-send-email-zhangfei.gao@linaro.org>
 <53FEF4A7.2040001@gmail.com>
Message-ID: <20140828171228.GR14650@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 10:21:43AM +0100, Dinh Nguyen wrote:
> 
> 
> On 8/28/14, 12:34 AM, Zhangfei Gao wrote:
> > Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > ---
> >  arch/arm/boot/dts/hisi-x5hd2.dtsi |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> > index 152f3ad..7b1cb53 100644
> > --- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
> > +++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> > @@ -365,6 +365,15 @@
> >  				#interrupt-cells = <2>;
> >  				status = "disabled";
> >  			};
> > +
> > +			wdg0: wdg at a2c000 {
> 
> A nit-pick here, but everybody else is using 'wdt' for a watchdog timer
> node.
> 
> > +				compatible = "arm,sp805", "arm,primecell";
> 
> I didn't see an entry for "arm,sp805" in Documentations, should there be
> one?

There probably should, yes. It looks like only the sp804 is documented.

Pawel, it looks like you were the first sp805,sp810 dt user. Care to put
together a couple of documents? ;)

Mark.
