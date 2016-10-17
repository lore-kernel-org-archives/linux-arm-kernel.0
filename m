From: randy.li@rock-chips.com (Randy Li)
Date: Mon, 17 Oct 2016 09:12:50 +0800
Subject: rockchip: drm: analogix_dp-rockchip would stock the kernel
In-Reply-To: <580421E5.9030609@rock-chips.com>
References: <1a7ebbe4-a9d8-610d-7cd5-41f5fe8355a5@soulik.info>
 <580421E5.9030609@rock-chips.com>
Message-ID: <e04e8feb-030e-5c74-cc77-5b6f58e24a2d@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/17/2016 08:57 AM, Mark yao wrote:
> On 2016?10?16? 02:03, ayaka wrote:
>> Hello:
>>    I meet a problem with eDP in rk3288 with the linux next 20161006,
>> it is just like the early stage of 4.4
>> kernel.  I have added a eDP panel entry in the firefly reload board,
>> once the kernel loaded analogix_dp-rockchip.ko, after printed the
>> following two lines, the kernel stop working.
>> rockchip-drm display-subsystem: bound ff940000.vop (ops
>> vop_component_ops [rockchipdrm])
>> rockchip-drm display-subsystem: bound ff930000.vop (ops
>> vop_component_ops [rockchipdrm])
>
> Hi ayaka
>
> This log seems no problem.
I found the problem, it is the eDP_AVDD_1V0 and eDP_AVDD_1V8 must have a 
proper power supply. I would submit a patch to enable the regulator at 
DP driver.
>
> How about tested it with build-in? we had test it with build-in.
>
> Maybe this patch can help you, you can have a try.
>     https://patchwork.kernel.org/patch/9374135
>
> Thanks.
>
>> In the early June of the 4.4 kernel, I meet the same problem with
>> rk3288 evb board with different error message, I have to disable the
>> display system that time.
>>   In the today test, I meet the same problem with rk3399 evb board in
>> 4.4.
>>   I have no idea what caused that, and it is a little hard to debug as
>> kernel still would never kill that task.
>>                                                             Randy Li
>>
>>
>>
>
>

-- 
Randy Li
The third produce department
===========================================================================
This email message, including any attachments, is for the sole
use of the intended recipient(s) and may contain confidential and
privileged information. Any unauthorized review, use, disclosure or
distribution is prohibited. If you are not the intended recipient, please
contact the sender by reply e-mail and destroy all copies of the original
message. [Fuzhou Rockchip Electronics, INC. China mainland]
===========================================================================
