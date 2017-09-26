From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 15:17:05 +0200
Subject: [PATCH v2 03/10] pinctrl: axp209: use drv_data of
 pinctrl_pin_desc to store pin reg
In-Reply-To: <20170926130108.uibnri32b73elfy6@flea>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
 <7993a30fbc2e50a2d228fa0c8fad643c4034b101.1506428208.git-series.quentin.schulz@free-electrons.com>
 <20170926130108.uibnri32b73elfy6@flea>
Message-ID: <0ae64e95-ee49-fb4c-e79b-e8c25c86580c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 26/09/2017 15:01, Maxime Ripard wrote:
> On Tue, Sep 26, 2017 at 12:17:13PM +0000, Quentin Schulz wrote:
>> Instead of using a function to retrieve each pin's correct control
>> register, use drv_data within pinctrl_pin_desc to store the ctrl reg.
>>
>> Remove axp20x_gpio_get_reg and replace every occurrence by a get from
>> drv_data.
> 
> Why do you need to do that? This should be explained.
> 

Agreed that it misses an explanation.

Today, to get a register addr of one of the GPIOs in the PMIC, we
basically get the GPIO number and returns the register via this info.

There are 3 GPIOs in AXP209, 2 in AXP813. I didn't want to have a switch
case for the GPIO number and then an if/else inside one of the case to
check if the device is AXP209 or AXP813 in which case we return -EINVAL
instead of the GPIO2 reg. With support for new PMIC, we would have a
bunch of if conditions and complexify the process for something really
simple.

IMHO, this also allows easier integration of future PMICs which might
have different regs for the GPIOs.

I don't *need* it but I find this solution nicer.

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/9d10b27f/attachment.sig>
