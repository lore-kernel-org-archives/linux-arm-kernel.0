From: julien.grall@linaro.org (Julien Grall)
Date: Wed, 09 Apr 2014 17:31:00 +0100
Subject: [RFC] Extend zImage format to support notes
In-Reply-To: <20140407182553.GD14062@e106331-lin.cambridge.arm.com>
References: <5342AF59.3030405@linaro.org>
 <20140407160452.GB14062@e106331-lin.cambridge.arm.com>
 <5342E02C.4010004@linaro.org>
 <20140407182553.GD14062@e106331-lin.cambridge.arm.com>
Message-ID: <534575C4.2020906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 04/07/2014 07:25 PM, Mark Rutland wrote:
> 
> I'm probably being thick here, but is there anything preventing those
> foreign pages from being idmapped into DOM0 (at least for the duration
> of the DMA access) such that there is a 1-1 PA<->IPA mapping?
> 
> That would mean that from the point of view of Linux, there's nothing to
> care about, as every address it knows it can deal with is a valid IPA.
> Existing kernels would function with the IOMMU(s) on.
> 
> I assume I'm missing something fairly obvious :)

I didn't though about this solution. It works on midway only when the
physical address size is 32 bits.

I didn't yet figure out why. I guess this is because I have a bug in my
SMMU driver in Xen.

>> We though about runtime approach (see the whole discussion here
>> https://patches.linaro.org/26034/), but it's not as extensible as notes.
>> In fact, we might need more notes in the future when new feature will be
>> added and requires a DOM0/guest side support.
> 
> I can certainly see the usefulness of notes.

[..]

> If it makes sense for this case then I can see why we would want it on
> arm64.

With the solution of idmapping, the RFC seems irrelevant for now. But we
may need to add notes in the future.

I'm wondering if it would be worth to agree on a solution now. Thus, we
will be able to add a note quickly when it will be necessary.

Any thoughts?

Sincerely yours,

-- 
Julien Grall
