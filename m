From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 11 Apr 2016 09:04:29 +0800
Subject: [PATCH] irqchip/mbigen: Display message of MBIGEN domain created
In-Reply-To: <57078BE8.8040604@arm.com>
References: <1460099762-51497-1-git-send-email-wangkefeng.wang@huawei.com>
 <20160408090935.4ec95aa8@arm.com> <57076B2D.8050006@huawei.com>
 <20160408095325.49aaf6b0@arm.com> <570788E3.3080901@huawei.com>
 <57078BE8.8040604@arm.com>
Message-ID: <570AF81D.90302@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/8 18:46, Marc Zyngier wrote:
> On 08/04/16 11:33, Kefeng Wang wrote:
>>
>>
>> On 2016/4/8 16:53, Marc Zyngier wrote:
>>> On Fri, 8 Apr 2016 16:26:21 +0800
>>> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
[...]
>> But there is still one issue in the for_each_child_of_node loop of
>> mbigen_device_probe. Assume that there are 3+ child node(mbigen_gmac,
>> mbigen_i2c, mbigen_xxx, etc) in mbigen_chip_dsa, if one of them with
>> incorrect configuration, then the loop will end, but we still need 
>> parse the left child node. we should consider this situation, right?
> 
> That's up to whoever designed the driver to decide, really. I don't know
> if it is worth continuing in that case (and you are in a better position
> than me to find out).

Ok, will talk with Ma Jun directly, and if the change is needed, I will send
a new patch after reviewed by Ma Jun.

Thanks,
Kefeng
