From: u@pkh.me (=?utf-8?B?Q2zDqW1lbnQgQsWTc2No?=)
Date: Tue, 15 Aug 2017 17:01:39 +0200
Subject: [PATCH 2/2] arm64: dts: hi6220: add acpu_sctrl
In-Reply-To: <5992F7FB.9080709@hisilicon.com>
References: <1492478242-16146-1-git-send-email-zhangfei.gao@linaro.org>
 <1492478242-16146-2-git-send-email-zhangfei.gao@linaro.org>
 <5992F7FB.9080709@hisilicon.com>
Message-ID: <20170815150138.GL22218@golem.pkh.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 02:32:43PM +0100, Wei Xu wrote:
> Hi Zhangfei,
> 
> On 2017/4/18 2:17, Zhangfei Gao wrote:
> > Add acpu_sctrl clock node
> > 
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Signed-off-by: Li Pengcheng <lipengcheng8@huawei.com>
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > index 470461d..710cc34 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> > @@ -262,6 +262,12 @@
> >  			#clock-cells = <1>;
> >  		};
> >  
> > +		acpu_sctrl: acpu_sctrl at f7032000 {

I think the unit address is incorrect here (this value has been copied
from the pm controller while it should match the 1st one the reg).

> > +			compatible = "hisilicon,hi6220-acpu-sctrl", "syscon";
> > +			reg = <0x0 0xf6504000 0x0 0x1000>;
> > +			#clock-cells = <1>;
> > +		};
> > +
> >  		medianoc_ade: medianoc_ade at f4520000 {
> >  			compatible = "syscon";
> >  			reg = <0x0 0xf4520000 0x0 0x4000>;
> > 

Also I'm sorry I'm going to ask stupid questions:

- why 's' in "sctrl" while all the other node controllers declared around
  seems to use "ctrl"?

- is it possible to have access to the specs where those addresses can be
  found? The only public doc I could find is the "Hi6220V100 Multi-Mode
  Application Processor" one where this information doesn't seem present.

- is there any work pending adding the pmu counters node (interrupt
  GCI_SPI 99) ? AFAIK the ACPU controller added here can be used to enable
  the counters.

> 
> Thanks!
> Applied to the hisilicon dt tree since the driver part is in the mainline now.
> 

Is this refering to https://github.com/hisilicon/linux-hisi/commits/next/dt64 ?

[...]

-- 
Cl?ment B.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170815/a60c3354/attachment.sig>
