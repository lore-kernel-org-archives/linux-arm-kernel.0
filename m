From: khilman@ti.com (Kevin Hilman)
Date: Fri, 29 Jun 2012 09:00:48 -0500
Subject: [PATCH] I2C: OMAP: fix runtime PM get/put balance on error
In-Reply-To: <4FEDA5C2.3000905@ti.com> (shubhrajyoti@ti.com's message of "Fri,
 29 Jun 2012 18:25:30 +0530")
References: <1340960868-7371-1-git-send-email-shubhrajyoti@ti.com>
 <874npunx6a.fsf@ti.com> <4FEDA5C2.3000905@ti.com>
Message-ID: <87395emd4f.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti <shubhrajyoti@ti.com> writes:

> On Friday 29 June 2012 05:32 PM, Kevin Hilman wrote:
>> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>>
>>>     ensure pm_runtime_put() is called, on pm_runtime_get_sync()
>>>     failure.
>>>
>>>     Without this, after a failed call, the runtime PM usecount will have
>>>     been incremented, but not decremented causing the usecount to never
>>>     reach zero after a failure. Thanks to Kevin for educating about it. 
>>>     While at it also fix a missing pm_runtime_disable in the probe error
>>>     path.
>> This is the same subject and changelog as the patch I sent, but is a
>> different patch.  
>>
>> Please write a new subject and a changelog specific to your patch.
> OK.
> Actually I did that on purpose your patch fixed the xfer call only.
> I thought that since get_sync increments the count always we could extend
> the patch to all the callers.
>>
>> As this changes the error/failure path, please be specific about how
>> the failure modes were tested, and on which platforms.
> I found and fixed by review only.
> Didnt really hit the failure case.

Which is why you should't just add stuff to other peoples work.

My patch was targetted at the XFER problem during suspend/resume which I
found by testing and and proved the fix by testing.

Your patch adds several additional functional changes that were not well
described and not tested.  That calls for a separate patch with seprate
subject/changelog etc.

Kevin
