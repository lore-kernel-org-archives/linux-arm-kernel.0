From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Fri, 29 Jan 2016 18:02:58 -0600
Subject: [PATCH 00/13] dtb: amd: Miscelleneous Updates for AMD Seattle DTS
In-Reply-To: <CAOesGMhG-dy9CJ+hLr_OV73BnKo-mstDjfDyhQhjvUnZ8pCAYA@mail.gmail.com>
References: <1453929121-12171-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <CAOesGMgRC2vTVdmY6kKYonM1JkWD=-3k_EQ4hGvyrm-vNZczrQ@mail.gmail.com>
 <56AA9436.60800@amd.com>
 <CAOesGMhG-dy9CJ+hLr_OV73BnKo-mstDjfDyhQhjvUnZ8pCAYA@mail.gmail.com>
Message-ID: <56ABFDB2.8050008@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/28/2016 8:43 PM, Olof Johansson wrote:
> On Thu, Jan 28, 2016 at 2:20 PM, Suravee Suthikulanit
> <suravee.suthikulpanit@amd.com> wrote:
>> Hi Olof,
>>
>> On 1/28/2016 3:39 PM, Olof Johansson wrote:
>>>
>>> Hi Suravee,
>>>
>>> On Wed, Jan 27, 2016 at 1:11 PM, Suravee Suthikulpanit
>>> <Suravee.Suthikulpanit@amd.com> wrote:
>>>>
>>>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>>
>>>> This patch series contains several updates for the AMD Seattle SOC DTS
>>>> files.
>>>> It also adds new board files for newer Overdrive and Linaro 96boards
>>>> (Husky)
>>>> platforms.
>>>
>>>
>>> My Overdrive comes with DT provided by firmware, so there's no need to
>>> have a in-kernel-tree DT source.
>>
>>
>> You are correct that the FW comes with DT, and in typical case, you wouldn't
>> need this.
>>
>>> Are you aware of other reasons to have it here? I just foresee
>>> divergence and conflicts between the two. It was quite obvious before
>>> this update when the FW-provided DT was a lot more complete than what
>>> we had in the kernel tree.
>>
>>
>> However, there are still new/updated drivers being developed, and sometimes
>> requires new/changes in DT binding. So, the DT that comes with the FW can
>> get out of date, and will lack the support for new drivers.
>
> Note that it's expected that the driver will cope with the old DT
> contents, i.e. it needs to go with defaults that made sense before the
> binding was updated.
>
> It, however, doesn't have to enable new features. In other words,
> booting with an old DT needs to continue working. You can't require a
> user to update DT to avoid getting driver breakage.
>
> (The opposite is not enforced: Booting with a DT that is newer than
> the kernel isn't guaranteed to always work).

Ok. I understand your point that driver will not break the existing DT. :)

>> Certain version of the FW allows overriding the DT that comes with the FW.
>> So, we are providing the in-kernel DT to allow developers to provide the
>> updated device tree for newer kernels. This patch series is bringing the
>> in-kernel DT closer to what the latest FW is providing to avoid potential
>> conflicts.
>
> I do appreciate keeping the kernel one up to date with what firmware
> provides if it's truly needed, but I'd even more prefer that it
> wasn't. After all, it's how the ACPI-based booting works (no
> overriding table provided with the kernel), so it's a model you should
> already be somewhat familiar with. :)

Agree. This is true in the x86 world where things are mostly stable.

However, in the ARM64 cases, there are still newer supports being added. 
Often that I have been asked by folks to provide a base DT that they can 
extend (e.g. to add support for platform device pass-through, PCI 
pass-through, SBSA GWDT, etc). Eventually, this in-kernel DT would not 
be needed as the more stable DT would have already been in the later 
version of the FW. But in the meantime, it seems useful to have this in 
one accessible place.

Thanks,
Suravee

> I'm not doing a hard NAK on this, but I would like to get a bit more
> understanding of why it's considered needed.
>
>
> -Olof
>
