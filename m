From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jul 2012 08:35:18 +0100
Subject: [PATCH 17/18] ARM: ux500: Add all encompassing Sound node to
 DB8500 Device Tree
In-Reply-To: <20120729205227.GL4384@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-18-git-send-email-lee.jones@linaro.org>
 <20120729205227.GL4384@opensource.wolfsonmicro.com>
Message-ID: <50163936.1050901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/12 21:52, Mark Brown wrote:
> On Fri, Jul 27, 2012 at 01:46:01PM +0100, Lee Jones wrote:
>
>>   arch/arm/boot/dts/db8500.dtsi |    8 ++++++++
>
> This is a generic DT include file but...
>
>> +		sound {
>> +			compatible = "stericsson,snd-soc-mop500";
>> +
>> +			stericsson,platform-pcm-dma = <&pcm>;
>> +			stericsson,cpu-dai = <&msp1 &msp3>;
>> +			stericsson,audio-codec = <&codec>;
>> +		};
>
> ...this is clearly the board-specific setup for the system, showing how
> the CPU and CODEC are hooked up.  This should therefore be in the DT for
> whatever board this is you're working on.

I don't think it's board specific. I believe this is the setup on all 
db8500 platforms. I'm happy to be told I'm wrong here, in which case I 
can move it to the board specific files.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
