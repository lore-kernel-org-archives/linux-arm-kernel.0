From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Thu, 29 Aug 2013 17:35:03 +0530
Subject: [PATCH 1/3] ARM: AM33xx: hwmod: Add RNG module data
In-Reply-To: <alpine.DEB.2.02.1308291127250.19789@utopia.booyaka.com>
References: <1375777984-6267-1-git-send-email-lokeshvutla@ti.com>
 <1375777984-6267-2-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1308281845560.22040@utopia.booyaka.com>
 <521F12CA.8010608@ti.com>
 <alpine.DEB.2.02.1308291127250.19789@utopia.booyaka.com>
Message-ID: <521F38EF.4040203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thursday 29 August 2013 05:00 PM, Paul Walmsley wrote:
> Hi
> 
> On Thu, 29 Aug 2013, Lokesh Vutla wrote:
> 
>> On Thursday 29 August 2013 12:18 AM, Paul Walmsley wrote:
>>> Hi
>>>
>>> On Tue, 6 Aug 2013, Lokesh Vutla wrote:
>>>
>>>> Add RNG hwmod data for AM33xx SoC.
>>>>
>>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>
>>> I tried to queue this one, but it caused AM33xx boots to hang.  
>>> Thought it might be related to the patch ordering -- seems to me that 
>>> the clock change patch needed to come before this patch -- but if I 
>>> recall correctly, both BeagleBone and BeagleBone-LT still hung. 
>> This is because register address space is not passed in hwmod_data as it
>> is passed from dt. So we need to include 3/3 patch in this series to boot.
> 
> So this patch has a dependency on a DT data patch?  If so then please 
> upstream that through Benoit, and put in the patch description on this 
> patch that there's a dependency on that patch.  If you post those together 
> in a series, please make sure that the DT patch comes first so it doesn't 
> break 'git bisect'.
Ok, Ill repost these two patches and make sure that DT patch comes first
so that 'git bisect' will not break..
 
> 
> I've already queued the clock change patch for upstream.
> 
>> PS: Probe for this driver will be failed even after this. Support for 
>> this version of rng ip is already posted and pushed into cryptodev-2.6 
>> tree.
> 
> I don't quite understand, could you please rephrase?
I just meant that with these patches RNG IP as such is not functional
without the driver changes. 

Thanks and Regards,
Lokesh
> 
> - Paul
> 
