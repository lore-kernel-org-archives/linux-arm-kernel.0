From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 27 Sep 2018 14:35:52 -0700
Subject: [PATCH i2c-next v3 1/3] dt-bindings: i2c: aspeed: Add 'timeout'
 property as an optional property
In-Reply-To: <20180927205610.GA29022@bogus>
References: <20180926215842.23125-1-jae.hyun.yoo@linux.intel.com>
 <20180926215842.23125-2-jae.hyun.yoo@linux.intel.com>
 <20180927205610.GA29022@bogus>
Message-ID: <c045aceb-80e4-4f9f-7ff2-c30172f04b3e@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 9/27/2018 1:56 PM, Rob Herring wrote:
> On Wed, Sep 26, 2018 at 02:58:40PM -0700, Jae Hyun Yoo wrote:
>> This commit adds 'aspeed,timeout' property as an optional property
>> which can be used for setting 'timeout' value of
>> 'struct i2c_adapter'. With this patch, the timeout value can be
>> set through an I2C_TIMEOUT ioctl on cdev, or through this optional
>> DT property.
> 
> Isn't controlling this from userspace or relying on a default
> sufficient?  I can't see this needing to be highly tuned for each
> platform.
> 

It can be controlled using an ioctl command on an I2C cdev from
userspace if CONFIG_I2C_CHARDEV is enabled. A couple of I2C drivers use
their own specific default value for it but in general the common
default value (1 second) which is set by i2c core is sufficient.
But it still needs to be tuned for specific cases based on attached
devices' characteristic, on packet length, on bus speed and on etc.
Specifically in Aspeed I2C driver for BMC, it should be tuned
to support multi-master use cases properly, and it needs a device tree
property to apply this timeout value from the probing time of the
module.

> However, if we do have a property, it should be common.
> 

Okay, I'll change it to 'timeout'.

Thanks a lot,
Jae
