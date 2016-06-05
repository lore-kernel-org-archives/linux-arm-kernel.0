From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Sun, 5 Jun 2016 21:53:54 +0200
Subject: [PATCH v2 2/4] ARM: dts: imx6q: extend support for the cm-fx6
In-Reply-To: <db27a6f6905b4683bb256f884c25b088@rwthex-s2-b.rwth-ad.de>
References: <20160605182657.1706-1-christopher.spinrath@rwth-aachen.de>
 <90e7dea7dee342cf82ccedcd463a60fc@rwthex-s1-b.rwth-ad.de>
 <db27a6f6905b4683bb256f884c25b088@rwthex-s2-b.rwth-ad.de>
Message-ID: <2ade5c2a94f146269ece29d5761cb528@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Thanks for your review!

On 06/05/2016 09:14 PM, Fabio Estevam wrote:
> On Sun, Jun 5, 2016 at 3:26 PM,  <christopher.spinrath@rwth-aachen.de> wrote:
> 
>> +&pcie {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_pcie>;
>> +       reset-gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> 
> I suppose this should be active low, right?
> 
hmm, the vendor devicetree uses active high but does not set
reset-gpio-active-high. In a quick test it turned out that setting this
property keeps the pci bus in reset.
In fact, the linux driver ignores the polarity and falls back to active
low. This explains why specifying active high "worked" here...

So you are right and it should be active low. I'll fix that.

> With this fixed:
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> 

Thanks,
Christopher
