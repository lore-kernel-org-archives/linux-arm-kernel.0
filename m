From: wdc@rock-chips.com (David.Wu)
Date: Fri, 8 Jan 2016 21:12:29 +0800
Subject: [PATCH v1 1/3] i2c: rk3x: add calc_divs ops for new version
In-Reply-To: <20160104194042.GD1522@katana>
References: <1449844384-6236-1-git-send-email-wdc@rock-chips.com>
 <566F5FAC.3080404@rock-chips.com>
 <CAHp75VfkteDvC0KUXOXDik9rQeanTXLn9Qq3wux-0rxk5ZotNA@mail.gmail.com>
 <20160104194042.GD1522@katana>
Message-ID: <568FB5BD.9050809@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram, Andy

Thanks for your suggestion.
I will  use i2c_parse_fw_timings() function to replace it.

? 2016/1/5 3:40, Wolfram Sang ??:
>>>> +static int rk3x_i2c_v0_calc_divs(unsigned long clk_rate, unsigned long
>>>> scl_rate,
>>>> +                                unsigned long scl_rise_ns,
>>>> +                                unsigned long scl_fall_ns,
>>>> +                                unsigned long sda_fall_ns,
>> Wolfram did some sturct to assign the parameters from device properties.
>> It might be re-used here.
> Yes, I think it makes sense to convert the driver first to use
> the new i2c_parse_fw_timings() function and see if it fits (or if we need
> to extend it perhaps).
>
> David, does this make sense to you?
>
