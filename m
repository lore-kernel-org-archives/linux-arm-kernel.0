From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:51:40 +0100
Subject: [PATCH] irqchip: gicv3-its: Use NUMA aware memory allocation for
 ITS tables
In-Reply-To: <CAFpQJXVh0ojzwqZmT5OgBArx9rpK0_yDw_+gyP8LAkT1e4HWrQ@mail.gmail.com>
References: <1498405569-463-1-git-send-email-shankerd@codeaurora.org>
 <CAFpQJXU84OTEp-1BteQeSqNy3Ya2hDskZA=Th_0f47qtS9-ucw@mail.gmail.com>
 <CAFpQJXVh0ojzwqZmT5OgBArx9rpK0_yDw_+gyP8LAkT1e4HWrQ@mail.gmail.com>
Message-ID: <ab7e26a8-5ab7-7c47-f19c-cb02fbd397b6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/17 04:01, Ganapatrao Kulkarni wrote:
> On Fri, Jun 30, 2017 at 8:04 AM, Ganapatrao Kulkarni
> <gpkulkarni@gmail.com> wrote:
>> Hi Shanker,
>>
>> On Sun, Jun 25, 2017 at 9:16 PM, Shanker Donthineni
>> <shankerd@codeaurora.org> wrote:
>>> The NUMA node information is visible to ITS driver but not being used
>>> other than handling errata. This patch allocates the memory for ITS
>>> tables from the corresponding NUMA node using the appropriate NUMA
>>> aware functions.
> 
> IMHO, the description would have been more constructive?
> 
> "All ITS tables are mapped by default to NODE 0 memory.
> Adding changes to allocate memory from respective NUMA NODES of ITS devices.
> This will optimize tables access and avoids unnecessary inter-node traffic."

But more importantly, I'd like to see figures showing the actual benefit
of this per-node allocation. Given that both of you guys have access to
such platforms, please show me the numbers!

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
