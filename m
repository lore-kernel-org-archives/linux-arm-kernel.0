From: zonque@gmail.com (Daniel Mack)
Date: Wed, 27 Nov 2013 14:32:46 +0100
Subject: [PATCH v6] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <5295F211.1050605@ti.com>
References: <1384726754-27875-1-git-send-email-zonque@gmail.com>
 <52938A12.5030100@ti.com> <5295F211.1050605@ti.com>
Message-ID: <5295F47E.7030409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2013 02:22 PM, Sekhar Nori wrote:
> + Kevin
> 
> On Monday 25 November 2013 11:04 PM, Joel Fernandes wrote:
>> On 11/17/2013 04:19 PM, Daniel Mack wrote:
>>> This patch makes the edma driver resume correctly after suspend. Tested
>>> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
>>>
>>> All information can be reconstructed by already known runtime
>>> information.
>>>
>>> As we now use some functions that were previously only used from __init
>>> context, annotations had to be dropped.
>>>
>>> [nm at ti.com: added error handling for runtime + suspend_late/early_resume]
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> Tested-by: Joel Fernandes <joelf@ti.com>
>>> Acked-by: Joel Fernandes <joelf@ti.com>
>>
>> Hi Sekhar,
>>
>> Can you consider pulling this patch? It has been tested and Acked. Thanks.
> 
> Kevin had some inputs on previous version of this patch. Were you able
> to make sure he is okay with this version being merged?

I had concerns about the feedback I got, and haven't got answers yet.

In particular, I'm not convinced that using runtime PM to suspend
channels would actually save any power during runtime, or have any other
benefit. But I might be wrong - maybe someone at TI could comment on that?


Thanks,
Daniel
