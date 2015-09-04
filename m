From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 4 Sep 2015 16:33:26 +0530
Subject: [PATCH 0/4] omap: Fix broken address translation for pbias
In-Reply-To: <20150903151005.GU4215@atomide.com>
References: <1441279673-28105-1-git-send-email-kishon@ti.com>
 <20150903151005.GU4215@atomide.com>
Message-ID: <55E97A7E.8010308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thursday 03 September 2015 08:40 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [150903 04:31]:
>> pbias device stopped having memory resource after
>> "ARM: dts: <platform>: add minimal l4 bus layout with control module
>> support" got merged. This results in platform_get_resource returning
>> -EINVAL in pbias driver. This is because address translation fails
>> while trying to convert the address to resource which happens
>> during the device creation process during boot up.
>>
>> Even though after [1], reg property in pbias dt node is un-used,
>> it might be an issue if we plan to use it at a later point of time.
>>
>> Patch series is created on top of [1].
>>
>> [1] -> https://lkml.org/lkml/2015/9/3/51
>>
>> Verified the address in omap4 panda, omap5 uevm and dra72 boards.
> 
> Your other series is obviously needed for v4.3.. But seems these
> are also needed for stable? If so, which versions, v4.2+?

Both the series are needed from v4.1+. However since the 'reg' property
is not going to be used, I'm not sure if this series has to be marked
for stable.
> 
> Can you please just do a single patch with multiple Fixes tags
> as they fix regression for multiple commits? Doing tons of one
> liner patches for the same thing just creates commit log noise..

Sure.
> 
> Remember to not Cc stable when posting, I'll add that tag when
> committing if needed.

Sure.

Thanks
Kishon
