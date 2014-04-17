From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 17 Apr 2014 09:37:00 +0200
Subject: [PATCH 1/2] clk: socfpga: add divider registers to the main pll
 outputs
In-Reply-To: <534EEE9C.6070806@gmail.com>
References: <1397679270-29695-1-git-send-email-dinguyen@altera.com>
 <534EE6AF.4040001@gmail.com> <20140416204950.GK16054@pengutronix.de>
 <534EEE9C.6070806@gmail.com>
Message-ID: <73ppkg1k6b.fsf@unicorn.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dinh Nguyen <dinh.linux@gmail.com> writes:

> On 04/16/2014 03:49 PM, Steffen Trumtrar wrote:
>> Hi!
>>
>> On Wed, Apr 16, 2014 at 03:23:11PM -0500, Dinh Nguyen wrote:
>>>
>>>
>>> On 04/16/2014 03:14 PM, dinguyen at altera.com wrote:
>>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>>
>>>> The C0(mpu_clk), C1(main_clk), and C2(dbg_base_clk) outputs from the main
>>>> PLL go through a pre-divider before coming into the system. These registers
>>>> were hidden for the CycloneV platform, but are not used for the ArriaV
>>>
>>> Sorry but this should be "but are now used"
>>>
>>
>> ???
>>
>> I don't get it. Do we have these registers on the cyclone V AND arria V or do
>> we only have them on the arria V ?
>
> These registers are there for both CycloneV and ArriaV.They are 
> configured by the preloader, so it was "hidden" as a fixed-divider. I 
> could have designated these values as fixed for the ArriaV as well, but 
> it would be better if I just read this "hidden" register to get the 
> divider value.
>

Ah, okay, now I get it. Then we want to have these represented in the
clock tree of course. Especially when they are not fixed.

Regards,
Steffen

-- 
Pengutronix e.K.                           | Steffen Trumtrar            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
