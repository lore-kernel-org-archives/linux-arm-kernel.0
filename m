From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 20 Jul 2012 10:42:53 +0530
Subject: [RFC][PATCH v2 1/1] ARM: OMAP2+: PM: Register suspend ops even
 in the presence of DT blob
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EB14B1E@DBDE01.ent.ti.com>
References: <1342699728-19831-1-git-send-email-vaibhav.bedia@ti.com>
 <5008E10F.4080706@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EB14B1E@DBDE01.ent.ti.com>
Message-ID: <5008E8D5.3010007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 July 2012 10:31 AM, Bedia, Vaibhav wrote:
> On Fri, Jul 20, 2012 at 10:09:43, Nayak, Rajendra wrote:
>> On Thursday 19 July 2012 05:38 PM, Vaibhav Bedia wrote:
>>> As per the comment in omap2_common_late_init() looks like the
>>> original intent of the DT check was to treat only the PMIC
>>> and SR initialization differently. Recent changes to consolidate
>>> the suspend-resume code across OMAP3/4 resulted into the
>>> registration of suspend ops also being dependent on the check
>>> for DT blob. Since the suspend-resume operation should not
>>> really be dependent on the usage of DT remove this dependency
>>> by wrapping the PMIC and SR init under the DT check.
>>
>> So I am guessing you also tested suspend/resume on your hardware
>> with this patch, when booting with a DT blob, and it passed.
>>
>
> I am getting there ;)
>
> I am in the process of getting a real suspend/resume functional. As part
> of this I was just flow flushing the whole suspend process in the mainline
> kernel by putting in a dummy implementation for the .enter op and found that
> this change was needed.

Ok, good to know you are working on this. It might then make sense for
for you to also include this patch as part of that series?
It doesn't make much sense to register suspend ops which then break
suspend isn't it? Btw, whats the behavior on current mainline with
just this patch. Does it hang/crash or just prevent the system from
doing down?

>
> Regards,
> Vaibhav
