From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 27 Aug 2014 18:10:28 +0800
Subject: [PATCH v2 2/3] rc: Introduce hix5hd2 IR transmitter driver
In-Reply-To: <20140827095106.GA2712@gofer.mess.org>
References: <1408613086-12538-1-git-send-email-zhangfei.gao@linaro.org>
 <1408613086-12538-3-git-send-email-zhangfei.gao@linaro.org>
 <20140821100739.GA3252@gofer.mess.org> <53FD9BB7.6080207@linaro.org>
 <20140827095106.GA2712@gofer.mess.org>
Message-ID: <53FDAE94.8010404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Sean

On 08/27/2014 05:51 PM, Sean Young wrote:
> On Wed, Aug 27, 2014 at 04:49:59PM +0800, zhangfei wrote:
>> On 08/21/2014 06:07 PM, Sean Young wrote:
>>> On Thu, Aug 21, 2014 at 05:24:44PM +0800, Zhangfei Gao wrote:
>>> It would be useful is rdev->input_phys, rdev->input_id,
>>> rdev->timeout, rdev->rx_resolution are set correctly.
>>
>> OK, will set rdev->timeout, rdev->rx_resolution
>> Not sure the usage of rdev->input_id, why is it required?
>
> This is for the EVIOCGID ioctl on the input device which will be created
> for the rc device. This is used for delivering input events from decoded

Find EVIOCGID in drivers/input/evdev.c
Will use same value as sunxi-cir.c & gpio-ir-recv.c, if these value has 
no special requirement.
         rcdev->input_id.bustype = BUS_HOST;
         rcdev->input_id.vendor = 0x0001;
         rcdev->input_id.product = 0x0001;
         rcdev->input_id.version = 0x0100;

> IR. There is be no reason to run lircd if you use this method.
Do you mean kernel decoder is enough to cover?
We use user space lircd to cosider more flexibility, even some 
non-standard protocol.

Anyway both method can be supported, depending on whether setting the 
optional property "linux,rc-map-name" or not.

Thanks
