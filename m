From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 14 Jul 2014 12:10:21 -0700
Subject: [PATCH v2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
In-Reply-To: <CAKohpokdvtPj7jg88mon+EnHRCbUF7nqFWvmkFEMVh5WRzSS5A@mail.gmail.com>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
 <1405052287-4744-1-git-send-email-skannan@codeaurora.org>
 <CAKohponB9feyh50p+dL5hyU1ffHAzHU59G-sYCrCm1AbHQe9hw@mail.gmail.com>
 <53C0A648.9080909@codeaurora.org>
 <CAKohpokdvtPj7jg88mon+EnHRCbUF7nqFWvmkFEMVh5WRzSS5A@mail.gmail.com>
Message-ID: <53C42B1D.8070301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2014 11:13 PM, Viresh Kumar wrote:
> On 12 July 2014 08:36, Saravana Kannan <skannan@codeaurora.org> wrote:
>> On 07/10/2014 11:19 PM, Viresh Kumar wrote:
>>
>>>
>>> Please make sure you take care of these issues:
>>> - suspend/resume
>>> - hotplug
>>> - module insert/remove
>>
>> Ok, I was just at the current code. Does cpufreq_unregister_driver() even
>> really work correctly as it stands?
>>
>> It doesn't even seem to stop any of the governors/policies before it just
>> set the cpufreq_driver pointer to NULL.
>>
>> So, technically my v2 patch doesn't even make anything worse when it comes
>> to unregistering the cpufreq driver.
>
> Are you really sure about this? I have tested this *myself* earlier..
>
> subsys_interface_unregister() should take care of stopping/freeing governor
> stuff..
>

I was asking this question based on looking at the code. Didn't actually 
try it -- sent it just before being done for the day. I didn't know 
about the subsys_interface_unregister() coming into play here. I'll take 
a look.

Thanks for the pointer.

-Saravana


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
