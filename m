From: sasukewxt@163.com (Caesar Wang)
Date: Sat, 30 Jul 2016 07:13:33 +0800
Subject: [PATCH v3 1/4] iio: adc: rockchip_saradc: reset saradc controller
 before programming it
In-Reply-To: <20160729212833.GA12688@rob-hp-laptop>
References: <1469629447-544-1-git-send-email-wxt@rock-chips.com>
 <20160729212833.GA12688@rob-hp-laptop>
Message-ID: <579BE31D.6020802@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2016?07?30? 05:28, Rob Herring wrote:
> On Wed, Jul 27, 2016 at 10:24:04PM +0800, Caesar Wang wrote:
>> SARADC controller needs to be reset before programming it, otherwise
>> it will not function properly.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: linux-iio at vger.kernel.org
>> Cc: linux-rockchip at lists.infradead.org
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
>> ---
>>
>> Changes in v3:
>> - %s/devm_reset_control_get_optional()/devm_reset_control_get()
>> - add Guente's test tag.
>>
>> Changes in v2:
>> - Make the reset as an optional property, since it should work
>> with old devicetrees as well.
>>
>>   .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++
>>   drivers/iio/adc/Kconfig                            |  1 +
>>   drivers/iio/adc/rockchip_saradc.c                  | 30 ++++++++++++++++++++++
>>   3 files changed, 38 insertions(+)
> Please add acks when posting new versions.

I didn't get your ACK when posting the V3. :-P

---
Your ack on 2016-07-27 23:12

  .../bindings/iio/adc/rockchip-saradc.txt           |  7 +++++

Acked-by: Rob Herring<robh@kernel.org>



>
> Rob
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
