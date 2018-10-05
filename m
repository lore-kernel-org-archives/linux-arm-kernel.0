From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Oct 2018 15:39:30 -0500
Subject: [PATCH i2c-next v6 1/5] dt-bindings: i2c: Add 'timeout-ms' and
 '#retries' properties as common optional
In-Reply-To: <20181004204322.20665-2-jae.hyun.yoo@linux.intel.com>
References: <20181004204322.20665-1-jae.hyun.yoo@linux.intel.com>
 <20181004204322.20665-2-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181005203930.GA12987@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 01:43:18PM -0700, Jae Hyun Yoo wrote:
> This commit adds 'timeout-ms' and '#retries' properties as common
> optional properties that can be used for setting 'timeout' and
> 'retries' values of 'struct i2c_adapter'. With this patch, the bus
> timeout value and the master transfer retries count can be set
> through these properties at the registration time of an adapter.
> Still the values can be set by I2C_TIMEOUT and I2C_RETRIES ioctls
> on cdev at runtime too.
> 
> These properties may not be supported by all drivers. However, if
> a driver wants to support one of them, it should adapt the
> bindings in this document.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
> index 11263982470e..6d7a6e919cf8 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c.txt
> @@ -80,6 +80,12 @@ wants to support one of the below features, it should adapt the bindings below.
>  	Names of map programmable addresses.
>  	It can contain any map needing another address than default one.
>  
> +- timeout-ms

bus-timeout-ms in case we have some other timeout needed.

> +	Bus timeout in milliseconds.
> +
> +- #retries
> +	Number of retries for master transfer.
> +
>  Binding may contain optional "interrupts" property, describing interrupts
>  used by the device. I2C core will assign "irq" interrupt (or the very first
>  interrupt if not using interrupt names) as primary interrupt for the slave.
> -- 
> 2.19.0
> 
