From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Wed, 10 Oct 2018 13:49:28 +0200
Subject: [PATCH] Doc: lockdep: add information about performance impact
In-Reply-To: <8a6bed3c-dac5-7031-eedd-2eb5bcc18478@arm.com>
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
 <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
 <20181009154359.GB5728@hirez.programming.kicks-ass.net>
 <20181009160633eucas1p1a597c95256e64bf01de32366afdc59dd~b-GGjOUFN2705527055eucas1p1b@eucas1p1.samsung.com>
 <8a6bed3c-dac5-7031-eedd-2eb5bcc18478@arm.com>
Message-ID: <20181010114929eucas1p26afb68895372532acd98a5fa641c6ab4~cPO77YHJM2672826728eucas1p2V@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 10/10/2018 12:31 PM, Robin Murphy wrote:
> On 09/10/18 17:06, Lukasz Luba wrote:
>> Hi Peter,
>>
>> On 10/09/2018 05:43 PM, Peter Zijlstra wrote:
>>> On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
>>>> This patch add some warning related to performance drop.
>>>> It should be mentioned that this is not for free
>>>> and the platfrom resources (cache, bus interconnect, etc.)
>>>> will be used more frequently.
>>>
>>> To me this reads a bit like: water is wet.
>>>
>>> Is this really needed?
>>>
>>>
>> Well, it would be good to know what is the performance drop
>> (10% or 20% or x3 times) when you are enabling different debug options.
>> I have spent some time analyzing these cache and bus strange behavior.
>> Now the developers would know that LOCKDEP might cause constant trashing
>> of your cache in some use cases.
> 
> Fair enough, but this is the wrong place for that. Anyone who's got as 
> far as reading how the internals of lockdep work can probably already 
> figure out that that brings a non-trivial overhead, whereas Joe 
> Developer wondering why his kernel is slow seems unlikely to happen 
> across this document by chance. And the people shipping devices with 
> PROVE_LOCKING enabled because it happened to mask some tricky bug, well, 
> they know what they did ;)
> 
> If you want to highlight to unwitting users that a tweaking a particular 
> config knob has a significant performance hit, at least put the warning 
> next to said knob, i.e. in the Kconfig help. For an example, DMA debug 
> comes to mind.
> 
> Robin.
> 
> 
Thank for the hint.
I agree, it would not be easy to find in this location.
I've found it during porting EAS where the
PROVE_LOCKING is used for arm and arm64
http://linux-arm.org/git?p=linux-power.git;a=blobdiff;f=arch/arm/configs/multi_v7_defconfig;h=e83c6e5bcfff97f8e9aacc4f2086ed506df63e59;hp=2721877d5a11f7fc41b8eb42d040ccde10eb0f3e;hb=737c15bf13632504e94509f0b9508122c664f3f2;hpb=288ae1d294d314b0aad5e0471605089da0336a77

I just wanted to give some rough performance impact measurements on
a real platform.

Regards,
Lukasz
