From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 22 Mar 2017 17:25:50 +0000
Subject: [PATCH v3 3/5] coresight: add support for debug module
In-Reply-To: <1e6d6a91-3bdc-7cfb-a96f-780c959e0316@arm.com>
References: <1488520809-31670-1-git-send-email-leo.yan@linaro.org>
 <1488520809-31670-4-git-send-email-leo.yan@linaro.org>
 <671a0b39-b635-6e0e-d3fa-967651f2e29c@arm.com>
 <CAJ9a7VgCjXNGC4C49PxL-nBxzhMCmA8Mb-0C_epahizA5EL2HA@mail.gmail.com>
 <e7a97c52-f61a-e503-f626-09563fa100b8@arm.com>
 <CAJ9a7VhvCS3xXAHBt0AUVB2Zp2P1HP_LQm4KiptiBT9VJ1fC0Q@mail.gmail.com>
 <4961636d-d77c-0f9a-7076-4db1ef456073@arm.com>
 <1e6d6a91-3bdc-7cfb-a96f-780c959e0316@arm.com>
Message-ID: <7a028460-d598-e337-5e09-234beddca88b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/03/17 17:09, Suzuki K Poulose wrote:
> On 22/03/17 16:17, Sudeep Holla wrote:

[...]

>> 
>> Point taken. So we could just specify that all necessary power
>> domains need to be on for proper functionality for this feature and
>> that it's highly platform specific instead of mixing cpu/cluster
>> idle details here.
>> 
>>> The key point is that the caveat in using this driver is that
>>> the power management has to be considered on a platform specific
>>> basis before it is configured; and appropriate actions may be
>>> needed for it to work correctly. Without this then the driver
>>> could cause more issues than it debugs. A user selecting this
>>> _must_ be told about these issues
>>> 
> 
> So given all the possible caveats, I think we :
> 
> 1) Shouldn't enable the driver by default at runtime even if it is 
> built-in. 
> 2) Should provide mechanisms to turn it on at boot (via
> kernel commandline) or anytime later (via sysfs), which kind of puts
> the responsibility back on the user : "You know what you are doing". 
> 3) Shouldn't turn the driver on based on "nohlt" which the user
> could use it for some other purposes, without explicit intention of
> turning this driver on).
> 4) Should document the fact that, on some
> platforms, the user may have to disable CPUidle explicitly to get the
> driver working. But let us not make it the default. The user with a
> not so ideal platform could add "nohlt" and get it working.
> 

Agreed on all points and well summarized.
I would like to highlight (3) and (4) as it needs to be well understood.

"nohlt" has a *different* meaning already, so using that in this
driver for something else is simple wrong as it affects the system in
unintended ways. And yes if user (mis)uses it to get things working,
it's fine but shouldn't be recommended way.

-- 
Regards,
Sudeep
