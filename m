From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 16 Mar 2018 07:44:40 +0800
Subject: [PATCH v7 3/3] dts: arm64: Add mailbox binding for hi3660
In-Reply-To: <5AAAA22E.5030009@hisilicon.com>
References: <1521130058-24796-1-git-send-email-leo.yan@linaro.org>
 <1521130058-24796-4-git-send-email-leo.yan@linaro.org>
 <5AAAA22E.5030009@hisilicon.com>
Message-ID: <20180315234440.GA18160@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 04:41:18PM +0000, Wei Xu wrote:
> Hi Leo,
> 
> On 2018/3/15 16:07, Leo Yan wrote:
> > From: Kaihua Zhong <zhongkaihua@huawei.com>
> > 
> > Add DT binding for mailbox driver.
> > 
> > Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
> > Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
> 
> Fine to me. Thanks!
> Acked-by: Wei Xu <xuwei5@hisilicon.com>

Thanks, Wei.

> Best Regards,
> Wei
> 
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > index 63d4f9d..3788448 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > @@ -298,6 +298,14 @@
> >  			#reset-cells = <2>;
> >  		};
> >  
> > +		mailbox: mailbox at e896b000 {
> > +			compatible = "hisilicon,hi3660-mbox";
> > +			reg = <0x0 0xe896b000 0x0 0x1000>;
> > +			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
> > +			#mbox-cells = <3>;
> > +		};
> > +
> >  		dual_timer0: timer at fff14000 {
> >  			compatible = "arm,sp804", "arm,primecell";
> >  			reg = <0x0 0xfff14000 0x0 0x1000>;
> > 
> 
