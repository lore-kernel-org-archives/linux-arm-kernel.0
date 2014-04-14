From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 14 Apr 2014 13:59:26 +0530
Subject: [PATCH] ARM: AM33xx: hwmod: Add INIT_NO_IDLE flag for debugss
 hwmod
In-Reply-To: <alpine.DEB.2.02.1404111807210.14347@utopia.booyaka.com>
References: <1397022467-6166-1-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1404111800430.14347@utopia.booyaka.com>
 <alpine.DEB.2.02.1404111807210.14347@utopia.booyaka.com>
Message-ID: <534B9C66.9020007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,
On Friday 11 April 2014 11:39 PM, Paul Walmsley wrote:
> On Fri, 11 Apr 2014, Paul Walmsley wrote:
> 
>> On Wed, 9 Apr 2014, Lokesh Vutla wrote:
>>
>>> During boot, when hwmod tries to cut clocks for debugss it always
>>> gets stuck in transition state and throws the following warning:
>>>
>>> [    0.139581] omap_hwmod: debugss: _wait_target_disable failed
>>>
>>> As per the information provided by folks, clocks to debugss cannot be cut.
>>> So adding HWMOD_INIT_NO_IDLE flag to debugss hwmod.
>>>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>
>> Thanks, queued for v3.15-rc.
> 
> Hmmm.  On second thought, this doesn't look like the right fix.  Could 
> you please comment on the issues raised here:
> 
> https://patchwork.kernel.org/patch/2212111/
Yes, I initially created a driver for enabling and disabling clocks for DEBUGSS.
But I always see that DEBUGSS is always stuck in transition whenever clocks are cut
to DEBUGSS. 
During boot also when hwmod tries to cut clocks the following warning comes:
  [    0.139581] omap_hwmod: debugss: _wait_target_disable failed.

As confirmed by the hardware team that this is a bug in silicon that clocks cannot
be cut to DEBUGSS.
So I am just adding HWMOD_INIT_NO_IDLE flag to debugss hwmod. 

I have also tested suspend-resume with $subject patch with TI internal tree.

Please let me know if I am not clear.

Thanks and regards,
Lokesh

> 
> Looks to me like there should be at least one device driver, either for 
> the entire DEBUGSS, or for the individual IP blocks inside the DEBUGSS.
> 
> Dropping this patch for now.
> 
> 
> - Paul
> 
