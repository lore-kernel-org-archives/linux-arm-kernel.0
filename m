From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 28 Mar 2013 00:32:13 +0530
Subject: [PATCH 3/9] ARM: OMAP2+: PM: Remove bogus fiq_[enable/disable]
 tuple
In-Reply-To: <874nfw8zb7.fsf@linaro.org>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-4-git-send-email-santosh.shilimkar@ti.com>
 <874nfw8zb7.fsf@linaro.org>
Message-ID: <51534235.6030506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 March 2013 12:06 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> On OMAP platform, FIQ is reserved for secure environment only. If at all
>> the FIQ needs to be disabled, it involves going through security
>> API call. Hence the local_fiq_[enable/disable]() in the OMAP code is bogus.
>>
>> So just get rid of it.
> 
> What about GP devices?
> 
On GP devices as well FIQ isn't available for non-secure software since
its marked secure only in ROM initialization. There has been heavy
debate on this since some customers wanted to have it available
for debug purpose but some other work-around was done rather
than opening it for public.

Regards,
Santosh
