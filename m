From: david.wu@rock-chips.com (David.Wu)
Date: Fri, 15 Apr 2016 20:10:16 +0800
Subject: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <20160414184848.GB2338@katana>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
 <20160414184848.GB2338@katana>
Message-ID: <5710DA28.6010104@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

? 2016/4/15 2:48, Wolfram Sang ??:
>> + - input-clk-rate : frequency rate of function clock used(in Hz). If omitted,
>> +	the default clock rate is used. It is just used at rk3399 soc.
> Why is this needed? Why don't we simply use the default or calculate the
> best value somehow?
The default frequency rate of function clock is 50M Hz, it can match F/S 
mode,
but HS mode not. If use default rate 50M to get 1.7M scl-frequency rate 
, we could not
get accurately 1.7M frequecy rate. The input-clk-rate is more higher, we 
get more
accurately scl-frequency rate,  as 200M is a suitable input-clk-rate.

If 200M was used for F/S mode, it would increase power consumption, so 
add a option that
could be configured from DT.

>> + * @t_calc: Caculated rk3x private timings  that would
>> + * be written into regs
> double space
>
