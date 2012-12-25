From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Tue, 25 Dec 2012 10:22:29 +0530
Subject: [PATCH] clk: debug clock tree
In-Reply-To: <CAPtuhTh9h6tJehZAJtyRB6bBESAYaqeN=v+dhmoavQG1euzqdw@mail.gmail.com>
References: <1355370586-6600-1-git-send-email-pgaikwad@nvidia.com>
 <CAPtuhThBigSQMkNDf16Fo1tddTKo=rPEydHmzep0DqtgLrB+HA@mail.gmail.com>
 <50CA17FB.9060606@wwwdotorg.org> <50D2A7DA.5050907@nvidia.com>
 <CAPtuhTgytOHGpVQ+vXQMpgFhuUo+y0H-QqpLg5cff2cdC-Rkzg@mail.gmail.com>
 <50D6DC4E.9020205@nvidia.com>
 <CAPtuhTh9h6tJehZAJtyRB6bBESAYaqeN=v+dhmoavQG1euzqdw@mail.gmail.com>
Message-ID: <50D9310D.8010107@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 December 2012 11:07 PM, Mike Turquette wrote:
> On Sun, Dec 23, 2012 at 4:26 AM, Prashant Gaikwad <pgaikwad@nvidia.com> wrote:
>> On Saturday 22 December 2012 04:26 AM, Mike Turquette wrote:
>>> On Wed, Dec 19, 2012 at 11:53 PM, Prashant Gaikwad <pgaikwad@nvidia.com>
>>> wrote:
>>>> On Thursday 13 December 2012 11:31 PM, Stephen Warren wrote:
>>>>> On 12/13/2012 09:27 AM, Mike Turquette wrote:
>>>>>> On Wed, Dec 12, 2012 at 7:49 PM, Prashant Gaikwad <pgaikwad@nvidia.com>
>>>>>> wrote:
>>>>>>> Adds debug file "clock_tree" in /sys/kernel/debug/clk dir.
>>>>>>> It helps to view all the clock registered in tree format.
>>>>>>>
>>>>>> Prashant,
>>>>>>
>>>>>> Thanks for submitting this.  We've been talking about having a single
>>>>>> file for representing the tree for some time.
>>>>>>
>>>>>> Regarding the output format had you considered using a well known
>>>>>> format which can be parsed using well known parsing libs?  This avoids
>>>>>> needing a custom parser just for this one file.  JSON springs to mind
>>>>>> as something lightweight and well-understood.
>>>>> One advantage of the format below is that it's very easily
>>>>> human-readable, and it's not too hard to parse (although I guess you'd
>>>>> have to parse the indent level to get parent/child relation, which would
>>>>> suck a bit). Is there room to provide both? Otherwise, I guess the
>>>>> kernel could include a script to convert from JSON/whatever into the
>>>>> format below.
>>>>>
>>>>>>> For example:
>>>>>>>       clock                        enable_cnt  prepare_cnt  rate
>>>>>>> ---------------------------------------------------------------------
>>>>>>>     i2s0_sync                      0           0            24000000
>>>>>>>     spdif_in_sync                  0           0            24000000
>>>>>>>        spdif_mux                   0           0            24000000
>>>>>>>           spdif                    0           0            24000000
>>>>>>>              spdif_doubler         0           0            48000000
>>>>>>>                 spdif_div          0           0            48000000
>>>>>>>                    spdif_2x        0           0            48000000
>>>>>
>>>> Even I think that output must be easily human-readable. How about adding
>>>> sysfs to switch between human-readable and machine-readable format?
>>>> I will try come up with a implementation.
>>>>
>>> Do you mean a sysfs file which controls the output format?  How about
>>> just two different files?  One can be clk-dump (machine readable) and
>>> the other is clk-summary (human readable).
>>
>> It is also fine. Is this patch ok for human-readable format? or any
>> suggestions?
>> I will change the file name to clk-summary.
>>
> Prashant,
>
> Yes the format seems to be agreeable for human-readable format based
> on the feedback on the list.  Go ahead and keep the column titles and
> the dashed lines that I commented on earlier... my comments are less
> relevant if a separate machine-readable clk-dump file exists.

Thanks Mike!!

> Are you going to take a crack at JSON-formatted output for clk-dump?

I will work on it.

> Thanks,
> Mike
>
>>> Regards,
>>> Mike
>>
