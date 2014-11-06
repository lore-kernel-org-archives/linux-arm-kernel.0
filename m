From: nm@ti.com (Nishanth Menon)
Date: Thu, 6 Nov 2014 10:53:19 -0600
Subject: [PATCH] ARM: dts: Add am57xx-beagle-x15
In-Reply-To: <20141106164843.GY31454@atomide.com>
References: <1415290702-11353-1-git-send-email-nm@ti.com>
 <20141106163207.GF16896@saruman> <545BA3E6.90105@ti.com>
 <545BA513.2090907@ti.com> <20141106164843.GY31454@atomide.com>
Message-ID: <545BA77F.2080609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2014 10:48 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [141106 08:44]:
>> On 11/06/2014 10:37 AM, Tom Rini wrote:
>>
>>>>> device_type = "memory"; +		reg = <0x80000000 0x40000000>; /* 1GB
>>>>> to start. Target 2GB */
>>>>
>>>> 1GiB ? Why would you put this here btw ? u-boot fills this one up.
>>>
>>> Yes, it should either be the full and correct value or 0x0 (like a
>>> number of PowerPC platforms do) so it's clear something else gives us
>>> the right value here.
>>
>> Honest mistake, my bad.. I thought I cleaned up the patch! Sigh!!! i
>> will repost with proper 2GB. it is better that way in case being used
>> with "other bootloaders" which are not exactly too good like u-boot.
> 
> Can you also describe why all the always-on regulators are needed?
yep - will do that similar to
https://patchwork.kernel.org/patch/5125431/ - same rationale unless
there is any specific voltage rail that you are explicitly interested
in that needs additional explanation. Is there additional rails of
interest?



-- 
Regards,
Nishanth Menon
