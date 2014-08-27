From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 27 Aug 2014 16:49:59 +0800
Subject: [PATCH v2 2/3] rc: Introduce hix5hd2 IR transmitter driver
In-Reply-To: <20140821100739.GA3252@gofer.mess.org>
References: <1408613086-12538-1-git-send-email-zhangfei.gao@linaro.org>
 <1408613086-12538-3-git-send-email-zhangfei.gao@linaro.org>
 <20140821100739.GA3252@gofer.mess.org>
Message-ID: <53FD9BB7.6080207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/21/2014 06:07 PM, Sean Young wrote:
> On Thu, Aug 21, 2014 at 05:24:44PM +0800, Zhangfei Gao wrote:
>> From: Guoxiong Yan <yanguoxiong@huawei.com>

>> +	rdev->driver_type = RC_DRIVER_IR_RAW;
>> +	rdev->allowed_protocols = RC_BIT_ALL;
>> +	rdev->priv = priv;
>> +	rdev->open = hix5hd2_ir_open;
>> +	rdev->close = hix5hd2_ir_close;
>> +	rdev->driver_name = IR_HIX5HD2_NAME;
>> +	rdev->map_name = RC_MAP_LIRC;
>
> I'm not sure RC_MAP_LIRC is appropriate. If the hardware has no implicit
> remote, can this be stored in device tree like the sunxi-cir.c driver does?

OK? got it.
Will set optional property "linux,rc-map-name" for the map_name.
We usually use user space lirc decoder, so this optional property may 
not need to be set in dts.

>
>> +	rdev->input_name = "Hisilicon hix5hd2 Remote Control Receiver";
>
> It would be useful is rdev->input_phys, rdev->input_id,
> rdev->timeout, rdev->rx_resolution are set correctly.

OK, will set rdev->timeout, rdev->rx_resolution
Not sure the usage of rdev->input_id, why is it required?

Thanks for the suggestion.
