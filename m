From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 12 Apr 2016 11:48:21 -0700
Subject: [PATCH 1/4] drivers/bus: make brcmstb_gisb.c driver explicitly
 non-modular
In-Reply-To: <20160407012639.GA30748@localhost>
References: <1459113058-14340-1-git-send-email-paul.gortmaker@windriver.com>
 <1459113058-14340-2-git-send-email-paul.gortmaker@windriver.com>
 <20160407012639.GA30748@localhost>
Message-ID: <570D42F5.6070308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/16 18:26, Brian Norris wrote:
> On Sun, Mar 27, 2016 at 05:10:55PM -0400, Paul Gortmaker wrote:
>> The Kconfig for this driver is currently:
>>
>> config BRCMSTB_GISB_ARB
>>         bool "Broadcom STB GISB bus arbiter"
>>
>> ...meaning that it currently is not being built as a module by anyone.
>> Lets remove all modular references, so that when reading the driver
>> there is no doubt it is builtin-only.
>>
>> Since module_init translates to device_initcall in the non-modular
>> case, the init ordering remains unchanged with this commit.
>>
>> Cc: Brian Norris <computersforpeace@gmail.com>
>> Cc: Gregory Fong <gregory.0xf0@gmail.com>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> I think this driver probably doesn't make too much sense as a module
> anyway (among other things, we can't hook the ARM fault handler beyond
> init time, as it's marked __init). So:
> 
> Acked-by: Brian Norris <computersforpeace@gmail.com>
> 
> Might be good to get Florian's ack though, as I'm not using this
> platform any more.

I concur with Brian here, your changes look good:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Paul
-- 
Florian
