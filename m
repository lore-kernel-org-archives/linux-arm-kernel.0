From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu, 31 Jul 2014 19:42:58 +0200
Subject: Bad Page dump (help)
In-Reply-To: <20140731140044.GL30282@n2100.arm.linux.org.uk>
References: <20140729190700.GN17808@saruman.home>
 <53D9E10F.6040408@xenomai.org>
 <20140731140044.GL30282@n2100.arm.linux.org.uk>
Message-ID: <53DA8022.9070708@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 04:00 PM, Russell King - ARM Linux wrote:
> On Thu, Jul 31, 2014 at 08:24:15AM +0200, Gilles Chanteperdrix wrote:
>> On 07/29/2014 09:07 PM, Felipe Balbi wrote:
>>> Hi Russell,
>>>
>>> I'm bringing up a new board on today's linux-next but I'm having a bunch
>>> of bad_page() calls due to _mapcount not being zero (full logs
>>> attached). What could cause that ? Any hints on how to debug ? It's as
>>> if page_mapcount_reset() wasn't called for the pages which are causing
>>> issues.
>>
>> FWIW, the same issue appeared on a Cogent CSB637 board (the last board 
>> I use not using DT) in between 3.13 and 3.14. I ran a bisect and found 
>> that reverting the following commit:
> 
> I don't seem to have a bug report from you for this.

No, this is really low priority in my todo list, as this platform is
based on at91rm9200, which is probably not that much used now. I did not
really finished investigating, so was not ready for a report. Now that
someone sees the same bug, I thought it might be useful to add my
partial findings.

> 
>> Seemed to make the issue disappear. I later found out that changing the
>> kernel options also made the issue disappear.
> 
> Which kernel options?

Any option, adding ftrace for instance, or disabling CONFIG_PREEMPT, I
could not identify a pattern.


-- 
                                                                Gilles.
