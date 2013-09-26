From: robherring2@gmail.com (Rob Herring)
Date: Thu, 26 Sep 2013 16:42:28 -0500
Subject: [PATCH v2 0/2] ARM DT cpus/cpu and topology bindings
In-Reply-To: <20130926100250.GA20705@e102568-lin.cambridge.arm.com>
References: <1379330464-27917-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20130924160126.GC403@e102568-lin.cambridge.arm.com>
 <5242EA2E.1010106@gmail.com>
 <20130926100250.GA20705@e102568-lin.cambridge.arm.com>
Message-ID: <5244AA44.7070208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2013 05:02 AM, Lorenzo Pieralisi wrote:
> On Wed, Sep 25, 2013 at 02:50:38PM +0100, Rob Herring wrote:
>> On 09/24/2013 11:01 AM, Lorenzo Pieralisi wrote:
>>> [replying to self]
>>>
>>> Any further comments on this series ? If not, I think bindings are ready to be
>>> queued, but for that I need acks from DT maintainers.
>>
>> Who do you plan to take this? Is this dependent on something for 3.13?
>> If not, I'll apply it.
> 
> v3 on the lists, should be final. No, there are no dependencies on 3.13
> to the best of my knowledge. The problem with pre-v7 UP systems with
> cpus node #address-cells == 0 is still there and I would like to ask you
> please what we/I should do about that, it can trigger a considerable
> amount of churn. As soon as these bindings hit the mainline I will
> update the DT parsing code, I can easily take all pre-v7 UP dts out
> of the picture in the parsing loop (after all, reg property for those
> processors is useless), but the dts are _wrong_ regardless when these
> patches become the official bindings.

Given that this is really a don't care for the kernel, I'm not sure what
kernel change you are thinking. It is not the kernel's job to validate
the dtb, so I think the kernel should not care. We should do this sort
of validation at dtb build time at the latest. As to updating the dts
files, yes we should probably do that.

Rob
