From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 07 Jul 2017 17:21:18 +0800
Subject: [PATCH 2/2] pinctrl: sunxi: add support of R40 to A10 pinctrl
 driver
In-Reply-To: <20170707091838.64phmj2p5qvn3dxc@flea>
References: <20170706142822.20296-1-icenowy@aosc.io>
 <20170706142822.20296-3-icenowy@aosc.io>
 <20170706205030.e6wzn5n7ix3443cl@flea>
 <72337BAD-680C-46BC-8DF5-645028E08F65@aosc.io>
 <20170707091838.64phmj2p5qvn3dxc@flea>
Message-ID: <DFBE7288-B9E3-4823-93F2-D5D85095698D@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?7?7? GMT+08:00 ??5:18:38, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Fri, Jul 07, 2017 at 07:13:30AM +0800, Icenowy Zheng wrote:
>> 
>> 
>> ? 2017?7?7? GMT+08:00 ??4:50:30, Maxime Ripard
><maxime.ripard@free-electrons.com> ??:
>> >On Thu, Jul 06, 2017 at 10:28:22PM +0800, Icenowy Zheng wrote:
>> >>  	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
>> >>  		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> >>  		  SUNXI_FUNCTION(0x1, "gpio_out"),
>> >> -		  SUNXI_FUNCTION(0x2, "i2c0")),		/* SCK */
>> >> +		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
>> >> +		  SUNXI_FUNCTION_VARIANT(0x3,
>> >> +					 "pll_lock_dbg",
>> >> +					 PINCTRL_SUN8I_R40)),
>> >
>> >You have a number of lines where the wrapping is not consistent with
>> >the rest, such as this one, but also...
>> 
>> I think this one is because of extraordinary function name.
>
>Since you don't have a comment, I guess that's not really that bad.

Yes. I tried it and it can fit the space saved by having no comment.

>
>Maxime
