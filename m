From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 21 Dec 2012 16:56:44 -0600
Subject: [PATCH] clk: debug clock tree
In-Reply-To: <50D2A7DA.5050907@nvidia.com>
References: <1355370586-6600-1-git-send-email-pgaikwad@nvidia.com>
 <CAPtuhThBigSQMkNDf16Fo1tddTKo=rPEydHmzep0DqtgLrB+HA@mail.gmail.com>
 <50CA17FB.9060606@wwwdotorg.org> <50D2A7DA.5050907@nvidia.com>
Message-ID: <CAPtuhTgytOHGpVQ+vXQMpgFhuUo+y0H-QqpLg5cff2cdC-Rkzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 11:53 PM, Prashant Gaikwad <pgaikwad@nvidia.com> wrote:
> On Thursday 13 December 2012 11:31 PM, Stephen Warren wrote:
>>
>> On 12/13/2012 09:27 AM, Mike Turquette wrote:
>>>
>>> On Wed, Dec 12, 2012 at 7:49 PM, Prashant Gaikwad <pgaikwad@nvidia.com>
>>> wrote:
>>>>
>>>> Adds debug file "clock_tree" in /sys/kernel/debug/clk dir.
>>>> It helps to view all the clock registered in tree format.
>>>>
>>> Prashant,
>>>
>>> Thanks for submitting this.  We've been talking about having a single
>>> file for representing the tree for some time.
>>>
>>> Regarding the output format had you considered using a well known
>>> format which can be parsed using well known parsing libs?  This avoids
>>> needing a custom parser just for this one file.  JSON springs to mind
>>> as something lightweight and well-understood.
>>
>> One advantage of the format below is that it's very easily
>> human-readable, and it's not too hard to parse (although I guess you'd
>> have to parse the indent level to get parent/child relation, which would
>> suck a bit). Is there room to provide both? Otherwise, I guess the
>> kernel could include a script to convert from JSON/whatever into the
>> format below.
>>
>>>> For example:
>>>>     clock                        enable_cnt  prepare_cnt  rate
>>>> ---------------------------------------------------------------------
>>>>   i2s0_sync                      0           0            24000000
>>>>   spdif_in_sync                  0           0            24000000
>>>>      spdif_mux                   0           0            24000000
>>>>         spdif                    0           0            24000000
>>>>            spdif_doubler         0           0            48000000
>>>>               spdif_div          0           0            48000000
>>>>                  spdif_2x        0           0            48000000
>>
>>
>
> Even I think that output must be easily human-readable. How about adding
> sysfs to switch between human-readable and machine-readable format?
> I will try come up with a implementation.
>

Do you mean a sysfs file which controls the output format?  How about
just two different files?  One can be clk-dump (machine readable) and
the other is clk-summary (human readable).

Regards,
Mike
