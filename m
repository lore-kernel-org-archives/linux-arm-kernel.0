From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 17 Nov 2014 20:33:39 +0530
Subject: [PATCH v9] ARM: omap: edma: add suspend resume hook
In-Reply-To: <546636C3.8070202@zonque.org>
References: <1409043173-24357-1-git-send-email-zonque@gmail.com>
 <546635DB.4020202@ti.com> <546636C3.8070202@zonque.org>
Message-ID: <546A0E4B.5000901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 10:37 PM, Daniel Mack wrote:
> Hi Sekhar,
> 
> On 11/14/2014 06:03 PM, Sekhar Nori wrote:
>> I think I have asked this before, and I am still not sure why this call 
>> to pm_runtime_get_sync() is needed here. From my testing today, this 
>> does seem to be a a no-op and this call returns from rpm_resume() 
>> because of this check:
>>
>> 	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
>> 	    && dev->power.runtime_status == RPM_ACTIVE)
>> 		retval = 1;
> 
> Yes. IIRC, it was in fact not needed.
> 
>> So, AFAICS, the net effect is an increment of dev->power.usage_count
>> (which is already greater than 0) and its subsequent decrement at the
>> end of the function.
>>
>> After removing this call I did not see any EDMA malfunction as well 
>> (can access MMC/SD just fine after suspend/resume cycle).
>>
>> So, any objections to merging this patch with the attached hunk 
>> applied?
> 
> Looks good to me, we can still add it back later if it turns out to be
> needed.

Okay, thanks for the confirmation.

Regards,
Sekhar
