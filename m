From: caesar.wang@rock-chips.com (caesar)
Date: Thu, 07 Aug 2014 21:55:24 +0800
Subject: [PATCH v4 2/2] pwm: rockchip: Added to support for RK3288 SoC
In-Reply-To: <20140807131443.GA1540@ulmo.nvidia.com>
References: <1406197295-10604-1-git-send-email-caesar.wang@rock-chips.com>
 <1406197295-10604-3-git-send-email-caesar.wang@rock-chips.com>
 <20140807061842.GB17340@ulmo> <53E3795E.4080607@rock-chips.com>
 <20140807131443.GA1540@ulmo.nvidia.com>
Message-ID: <53E3854C.9070005@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry,

? 2014?08?07? 21:14, Thierry Reding ??:
> On Thu, Aug 07, 2014 at 09:04:30PM +0800, caesar wrote:
> [...]
>> As you say, I will rewrite the about if it's really need  do so it.
>> For example:
>>
>> static const struct rockchip_pwm_data pwm_data_v1 = {
>>      .regs = {
>>                  .duty = 0x04,
>>                  .period = 0x08,
>>                  .cntr = 0x00,
>>                  .ctrl = 0x0c,
>>      },
>>      .prescaler = 2,
>>      .set_enable = rockchip_pwm_set_enable_v1,
>> };
>>
>> static const struct rockchip_pwm_data pwm_data_v2 = {
>>      .regs = {
>>                  .duty = 0x08,
>>                  .period = 0x04,
>>                  .cntr = 0x00,
>>                  .ctrl = 0x0c,
>>      },
>>      .prescaler = 1,
>>      .set_enable = rockchip_pwm_set_enable_v2,
>> };
>>
>> static const struct rockchip_pwm_data pwm_data_vop = {
>>      .regs = {
>>                  .duty = 0x08,
>>                  .period = 0x04,
>>                  .cntr = 0x0c,
>>                  .ctrl = 0x00,
>>      },
>>      .prescaler = 1,
>>      .set_enable = rockchip_pwm_set_enable_v2,
>> };
>>
>> Is that right?
> Yes.
>
>>>> +	.set_enable = rockchip_pwm_set_enable_v2,
>>>> +};
>>> No need for the double indirection.
>> Sorry, I think is need if you mean a double indirection for ".set_enable".
> The "double indirection" was regarding the symbolic names for registers,
> not the .set_enable(). Sorry.
OK,I will fix the about in patch v5 tomorrow if no other problems,Thanks!
> Thierry
