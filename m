From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jul 2012 15:55:47 +0100
Subject: [PATCH 17/21] ASoC: Ux500: Enable ux500 PCM driver for Device Tree
In-Reply-To: <20120726142225.GJ3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-18-git-send-email-lee.jones@linaro.org>
 <20120726113838.GA3099@opensource.wolfsonmicro.com>
 <50114B89.7070100@linaro.org>
 <20120726142225.GJ3099@opensource.wolfsonmicro.com>
Message-ID: <50115A73.10603@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/12 15:22, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 02:52:09PM +0100, Lee Jones wrote:
>> On 26/07/12 12:38, Mark Brown wrote:
>
>>>> -	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
>>>> -	platform_device_register(&ux500_pcm);
>
>>> This has the same issue as your last patch...  the way you're doing
>>> things will break audio on all boards using this driver.
>
>> It will, why?
>
> You've just removed registration of the device and not added anything
> else to replace that.  Even if all boards convert to DT their DTs will
> need to be updated which you're not doing.

The initialisation function which calls platform_device_register() is 
only executed during a DT boot. The clue is in the title 
mop500_of_msp_init(). The DT is populated _before_ this patch, but I 
guess you mean if they are separated into subsystem trees and are placed 
into -next/Mainline out of order.

I will merge these patches with the DT population instead to overcome 
this possibility. It makes more sense to keep the arch/arm stuff 
together in any case.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
