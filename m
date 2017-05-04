From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 04 May 2017 22:45:11 +0800
Subject: [PATCH v2 03/10] pinctrl: sunxi: add A20 support to A10 driver
In-Reply-To: <20170504144152.34yzk424aqrizmbu@lukather>
References: <20170504135006.16483-1-icenowy@aosc.io>
 <20170504135006.16483-4-icenowy@aosc.io>
 <20170504140220.26kguf3trz7ocylv@lukather>
 <83062089-19CD-4805-A6DC-2C25D75621FF@aosc.io>
 <20170504144152.34yzk424aqrizmbu@lukather>
Message-ID: <52C75207-6F41-4B3F-8953-F4F040358792@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?5?4? GMT+08:00 ??10:41:52, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Thu, May 04, 2017 at 10:03:26PM +0800, Icenowy Zheng wrote:
>> 
>> 
>> ? 2017?5?4? GMT+08:00 ??10:02:20, Maxime Ripard
><maxime.ripard@free-electrons.com> ??:
>> >On Thu, May 04, 2017 at 09:49:59PM +0800, Icenowy Zheng wrote:
>> >>  static const struct of_device_id sun4i_a10_pinctrl_match[] = {
>> >> -	{ .compatible = "allwinner,sun4i-a10-pinctrl", },
>> >> +	{
>> >> +		.compatible = "allwinner,sun4i-a10-pinctrl",
>> >> +		.data = (void *)PINCTRL_SUN4I_A10
>> >> +	},
>> >> +	{
>> >> +		.compatible = "allwinner,sun7i-a20-pinctrl",
>> >> +		.data = (void *)PINCTRL_SUN7I_A20
>> >> +	},
>> >>  	{}
>> >>  };
>> >
>> >This means you're going to have two drivers probing for the same
>> >device: this driver, and the old one. This is not ok, and probably
>> >introduces some corner cases.
>> 
>> The A20 driver is dropped in the next commit.
>
>Yes, and that is an issue for bisectability. Anyone that will checkout
>between those two commits will have a broken kernel, and that is not
>ok. Any commit should be in a working state.

Squash them together?

>
>Maxime
