From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jul 2012 08:32:43 +0100
Subject: [PATCH 13/18] ARM: ux500: Add ux500 PCM to DB8500 Device Tree
In-Reply-To: <20120729205001.GK4384@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-14-git-send-email-lee.jones@linaro.org>
 <20120729205001.GK4384@opensource.wolfsonmicro.com>
Message-ID: <5016389B.4020003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/12 21:50, Mark Brown wrote:
> On Fri, Jul 27, 2012 at 01:45:57PM +0100, Lee Jones wrote:
>> Nothing special here. We're only providing a compatible string
>> to ensure the driver is probed using a Device Tree boot.
>
>> +		pcm: ux500-pcm {
>> +			compatible = "stericsson,ux500-pcm";
>> +		};
>> +
>
> One of two things is wrong here.  Either you've not provided any
> information about the hardware so the driver won't be able to work out
> what to talk to or you've not provided any data so you're registering a
> purely virtual Linux-internal device via the device tree.
>
> Once more, the idea here is to describe the hardware not to dump Linux's
> internal data structures into the device tree.

We use it register the driver for probe()ing. In the same way we do for 
the PMU and Regulators. All three of which actually belong to a 
different hardware block. Do you know of a better way to register those 
devices?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
