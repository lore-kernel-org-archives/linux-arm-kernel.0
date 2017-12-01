From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 30 Nov 2017 16:17:42 -0800
Subject: [PATCH v2 0/7] ARM: Broadcom Brahma-B15 readahead cache support
In-Reply-To: <1db4b690-2508-fd1d-1777-81bb4caf1102@gmail.com>
References: <20170623175227.19743-1-f.fainelli@gmail.com>
 <23e2f72f-bc22-2084-660f-bc793e68c174@gmail.com>
 <1db4b690-2508-fd1d-1777-81bb4caf1102@gmail.com>
Message-ID: <4a819b7b-2a57-9a0a-3f31-6cdcd84d6bbe@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2017 09:23 AM, Florian Fainelli wrote:
> 
> 
> On 07/14/2017 03:11 PM, Florian Fainelli wrote:
>> On 06/23/2017 10:52 AM, Florian Fainelli wrote:
>>> Hi all,
>>>
>>> This patch series adds support for the Broadcom Brahma-B15 readahead cache.
>>> I submitted that patch series a couple of years ago, and then slept on it so
>>> here is another stab at it.
>>>
>>> Note that we did not implement this cache as a version of an outer cache
>>> for several reasons:
>>>
>>> - we initially thought we needed to intercept flush_icache_all and
>>>   flush_kern_cache_louis but upon further inspection we convinced ourselves
>>>   this is no longer needed, still, flush_cache_all() needs special handling
>>>   here and needs to be wrapped around
>>>
>>> - the outer cache does not allow differentiating a DMA transfer direction
>>>   this is a readahead cache, so it does not participate in writes, flushing
>>>   it during reads *and* writes kills the performance completely
>>>
>>> - finally, most operations that outer_cache cares about are on MVA, which
>>>   is transparent to the readahead cache here
>>>
>>> Changes in v2:
>>>
>>> - clarify that the read-ahead caches does invalidates on writes (IOW) based
>>>   on Russell's feedback
>>
>> Any comments on this? Thank you.
> 
> Should I just go a ahead and queue these changes in Russell's patch tracker?

Per IRC conversation with Russell, queued into his patch tracking system as:

http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8724/1
http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8725/1
http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8729/1
http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8726/1
http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8730/1
http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8728/1
http://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8727/1
-- 
Florian
