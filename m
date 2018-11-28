From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 28 Nov 2018 22:54:59 +0100
Subject: [PATCH i2c-next v9 1/5] dt-bindings: i2c: Add 'bus-timeout-ms'
 and '#retries' properties as common optional
In-Reply-To: <20181030210917.32711-2-jae.hyun.yoo@linux.intel.com>
References: <20181030210917.32711-1-jae.hyun.yoo@linux.intel.com>
 <20181030210917.32711-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181128215458.GB1666@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 02:09:12PM -0700, Jae Hyun Yoo wrote:
> This commit adds 'bus-timeout-ms' and '#retries' properties as
> common optional properties that can be used for setting 'timeout'
> and 'retries' values of 'struct i2c_adapter'. With this patch, the
> bus timeout value and the master transfer retries count can be set
> through these properties at the registration time of an adapter.
> Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
> on cdev at runtime too.
> 
> These properties may not be supported by all drivers. However, if
> a driver wants to support one of them, it should adapt the
> bindings in this document.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Definately NACK on the #retries part. This is purely a configuration
thing. Besides that it is kind of ancient cruft, too. I don't recommend
it, at all.

On the timeout thing, I am still not fully convinced that this is a HW
description. I said that before. But maybe I need to understand your
problem case better.

> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
> index 11263982470e..bdead91f82a4 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c.txt
> @@ -80,6 +80,12 @@ wants to support one of the below features, it should adapt the bindings below.
>  	Names of map programmable addresses.
>  	It can contain any map needing another address than default one.
>  
> +- bus-timeout-ms
> +	Bus timeout in milliseconds.
> +
> +- #retries
> +	Number of retries for master transfer.
> +
>  Binding may contain optional "interrupts" property, describing interrupts
>  used by the device. I2C core will assign "irq" interrupt (or the very first
>  interrupt if not using interrupt names) as primary interrupt for the slave.
> -- 
> 2.19.1
> 
