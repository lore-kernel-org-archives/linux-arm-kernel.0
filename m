From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Feb 2014 22:02:02 -0700
Subject: [PATCH] ARM: tegra: add device tree for SHIELD
In-Reply-To: <530D748D.6010802@nvidia.com>
References: <1393237593-28121-1-git-send-email-acourbot@nvidia.com>
 <530B952D.2000006@wwwdotorg.org> <530BFC58.6020003@nvidia.com>
 <530D1B7A.9070209@wwwdotorg.org> <530D748D.6010802@nvidia.com>
Message-ID: <530D754A.60700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2014 09:58 PM, Alexandre Courbot wrote:
> On 02/26/2014 07:38 AM, Stephen Warren wrote:
>> On 02/24/2014 07:13 PM, Alexandre Courbot wrote:
>>> On 02/25/2014 03:53 AM, Stephen Warren wrote:
>>>> On 02/24/2014 03:26 AM, Alexandre Courbot wrote:
>>>>> Add a device tree for NVIDIA SHIELD. The set of enabled features is
>>>>> still minimal with no display option (although HDMI should be easy
>>>>> to get to work) and USB requiring external power.
...
>>> For the Wifi chip, non-removable would be the correct setting
>>> hardware-wise, but there is a trap: the chip has its reset line asserted
>>> at boot-time, and you need to set GPIO 229 to de-assert it. Only after
>>> that will the device be detected on the SDIO bus. Since it lacks a CD
>>> line, it must be polled, hence the broken-cd property.
>>
>> How does that GPIO get manipulated right now? I assume you must be
>> manually configuring it via sysfs after boot or something? If so,
>> perhaps it's best to just leave out the WiFi node until it works
>> automatically.
> 
> The GPIO needs to be set from user-space, yes. But if we leave the Wifi
> node out, I'm concerned that wireless will not be usable at all,
> wouldn't it?

True, but if we have no representation of the device in DT that works
without manually enabling clocks and/or GPIOs, it's not a
complete/accurate representation of the HW, so it doesn't make sense to
add it to DT. Yes, I admit that sucks.
