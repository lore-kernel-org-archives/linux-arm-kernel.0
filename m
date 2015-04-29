From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Wed, 29 Apr 2015 08:19:02 +0000
Subject: [PATCH v3 3/3] arm64: dts: Add mediatek MT8173 earlycon support
References: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
 <1430228434-31779-4-git-send-email-eddie.huang@mediatek.com>
 <20150429064454.GR6325@pengutronix.de>
Message-ID: <C2D7FE5348E1B147BCA15975FBA230756659C0C2@IN01WEMBXB.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015 12:15 PM, Sascha Hauer wrote:
> Hi Eddie,
>
> On Tue, Apr 28, 2015 at 09:40:34PM +0800, Eddie Huang wrote:
>> Add earlycon support to mediatek MT8173 evaluation board dts.
> This is not about earlycon support. It adds the stdout-path property
> which is generally about console.

Indeed, this is shorter way of specifying the default console by referring to uart
device.

>  It only happens to used for earlycon,
> but would be used as a regular console aswell if it wasn't broken for
> some kernel revisisions.

Really - I'm confused. When I last tried this for arc_uart (in 3.17 time frame),
it would setup default console, but to use it for earlycon we needed
bootargs=earlycon in chosen. However I had to revet that change since OF core
still was fixing a few things in that area.

See mainline 22524b02b17b901f28 ("Revert "ARC: [arcfpga] stdout-path now suffices
for earlycon/console"")

-Vineet

>
>>  
>> -	chosen { };
>> +	chosen {
>> +		linux,stdout-path = &uart0;
>> +	};
> Please use stdout-path, without the 'linux,'.
>
> Sascha
>
