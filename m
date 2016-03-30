From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Wed, 30 Mar 2016 14:38:08 +0000
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <20160330120644.GM20367@ibawizard.net>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <20160330120644.GM20367@ibawizard.net>
Message-ID: <1459348687.5073.53.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr

On Wed, 2016-03-30 at 14:06 +0200, Petr ?tetiar wrote:
> Krzysztof Ha?asa <khalasa@piap.pl> [2016-03-25 14:32:35]:
> 
> Cze??,
> 
> > 
> > I wonder if all boards (except maybe that Toradex set) use an
> > active-low
> > PCIe reset and are now broken. Perhaps Toradex uses active-high and
> > thus
> > works.
> I'm really puzzled by this :-) With your patch applied I get
> following on
> Toradex Apalis modules:
> 
> ?DTS:?????????reset-gpio = <&gpio1 28 GPIO_ACTIVE_LOW>;
> ?dmesg:???????imx6q-pcie 1ffc000.pcie: phy link never came up
> ?gpio:????????gpio-28??(????????????????????|reset???????????????)
> out hi
> ?pin voltage: 0V
> 
> ?DTS:?????????reset-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> ?dmesg:???????ath9k 0000:01:00.0: enabling device (0140 -> 0142)
> ?gpio:????????gpio-28??(????????????????????|reset???????????????)
> out lo
> ?pin voltage: 3V3
> 
> So Toradex Apalis is actually active-high?

Yes, I actually explained this in detail in my cover letter:

http://article.gmane.org/gmane.linux.drivers.devicetree/154829

>  Thanks.
> 
> -- ynezz


Cheers

Marcel
