From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Wed, 21 Mar 2018 17:18:47 +0800
Subject: Failed to boot ARM64 boards for recent linux-next
In-Reply-To: <680aba8d-4117-227b-d5a1-ad7121d2565f@arm.com>
References: <dae4b3b8-3da4-4a86-ac4a-0631802fa546@rock-chips.com>
 <077cecdd-7982-dd33-454f-e38cc571366c@arm.com>
 <9cff515e-fcb9-a1c0-329b-a18c3bed0071@rock-chips.com>
 <fe56e7e3-50dd-88de-ce61-f3cbcc1f572b@rock-chips.com>
 <5AB0DEB2.4000803@rock-chips.com>
 <e603186e-b9e8-c7d5-b98a-f5bcce94f7d5@arm.com>
 <cbc89d68-ba41-1f6a-4ab2-4c9647b48f75@huawei.com>
 <d18d6f27-7270-d2d7-58b9-3bf16ffe6b0a@arm.com>
 <ff6cd434-2227-12a6-b3b9-325da78a7fa9@huawei.com>
 <2aed10a0-ad3d-d9fc-7b6e-3b6877bff0be@arm.com>
 <13507742-ddb8-0b43-cd09-14a57ec2a07a@rock-chips.com>
 <5AB1F763.3040409@rock-chips.com>
 <680aba8d-4117-227b-d5a1-ad7121d2565f@arm.com>
Message-ID: <5AB22377.1000404@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 03/21/2018 04:52 PM, Marc Zyngier wrote:
> Hi Jeffy,
>
> On 21/03/18 06:10, JeffyChen wrote:
>> Hi Shawn,
>>
>> On 03/21/2018 08:34 AM, Shawn Lin wrote:
>>>
>>> @Jeffy
>>>
>>> Could you help test Marc's latest patch on your RK3399 kevin/Gru or
>>> whatever Chromebook?
>> tested on my chromebook kevin, it works with that patch.
>
> This is very odd. It completely fails on mine, which is aannoying.
> Do you have any special firmware? Or the stock firmware?
>

hmmm, my kevin's firmware is official:
localhost / # cat /var/log/bios_info.txt
version              | Google_Kevin.8785.241.0
ro bios version      | Google_Kevin.8785.241.0

and i also test it on my dru(another rk3399 chromebook) (force using 
kevin's dtb), it works too(although it dead at the end after i2c probed).


my kernel:
a9be5aeb6a31 irqchip/gic-v3: Check availability of Group0 before 
resetting AP0Rn
170b1830a3e7 Add linux-next specific files for 20180320
90385ca35f2f Merge branch 'akpm/master'
0a54b4dd1975 sparc64: NG4 memset 32 bits overflow

my kernel image and config:
https://emailattachment.net/sites/default/files/files/public/kernel.img
https://emailattachment.net/sites/default/files/files/public/config.config



> Thanks,
>
> 	M.
>
