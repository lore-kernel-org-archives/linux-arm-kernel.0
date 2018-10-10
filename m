From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 10 Oct 2018 11:31:43 +0100
Subject: [PATCH] Doc: lockdep: add information about performance impact
In-Reply-To: <20181009160633eucas1p1a597c95256e64bf01de32366afdc59dd~b-GGjOUFN2705527055eucas1p1b@eucas1p1.samsung.com>
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
 <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
 <20181009154359.GB5728@hirez.programming.kicks-ass.net>
 <20181009160633eucas1p1a597c95256e64bf01de32366afdc59dd~b-GGjOUFN2705527055eucas1p1b@eucas1p1.samsung.com>
Message-ID: <8a6bed3c-dac5-7031-eedd-2eb5bcc18478@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/18 17:06, Lukasz Luba wrote:
> Hi Peter,
> 
> On 10/09/2018 05:43 PM, Peter Zijlstra wrote:
>> On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
>>> This patch add some warning related to performance drop.
>>> It should be mentioned that this is not for free
>>> and the platfrom resources (cache, bus interconnect, etc.)
>>> will be used more frequently.
>>
>> To me this reads a bit like: water is wet.
>>
>> Is this really needed?
>>
>>
> Well, it would be good to know what is the performance drop
> (10% or 20% or x3 times) when you are enabling different debug options.
> I have spent some time analyzing these cache and bus strange behavior.
> Now the developers would know that LOCKDEP might cause constant trashing
> of your cache in some use cases.

Fair enough, but this is the wrong place for that. Anyone who's got as 
far as reading how the internals of lockdep work can probably already 
figure out that that brings a non-trivial overhead, whereas Joe 
Developer wondering why his kernel is slow seems unlikely to happen 
across this document by chance. And the people shipping devices with 
PROVE_LOCKING enabled because it happened to mask some tricky bug, well, 
they know what they did ;)

If you want to highlight to unwitting users that a tweaking a particular 
config knob has a significant performance hit, at least put the warning 
next to said knob, i.e. in the Kconfig help. For an example, DMA debug 
comes to mind.

Robin.
