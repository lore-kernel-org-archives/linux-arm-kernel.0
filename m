From: c.tirumalesh@gmail.com (tirumalesh chalamarla)
Date: Mon, 1 Sep 2014 08:18:58 -0700
Subject: [PATCH] iommu/arm-smmu: Allow size of stage 1 output to max
 possible value for sateg 2 bypass
In-Reply-To: <20140901151234.GE24594@arm.com>
References: <1409162541-3940-1-git-send-email-c.tirumalesh@gmail.com>
 <20140901114238.GB24594@arm.com>
 <CALuQcNn-d3_fQaygtObzeZL7OxU8BsstKMmCmpQMHEOF31b1RA@mail.gmail.com>
 <20140901151234.GE24594@arm.com>
Message-ID: <CALuQcNnbRO7p=daH6NT+7Ns2FgzTuaRrnLep4UNo2s6rMNvdHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 1, 2014 at 8:12 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Sep 01, 2014 at 02:49:58PM +0100, tirumalesh chalamarla wrote:
>> On Mon, Sep 1, 2014 at 4:42 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > Assuming I understand the problem correctly, why not simply remove the
>> > truncation from the existing code (untested patch below)? Does that not
>> > work for you?
>> >
>>
>> This will not restrict stage 1 out put to VA_BITS, even for two level
>> translations. this results in non debuggable problems
>> if we configure incorrectly.  there is no harm in checking the
>> condition for nested translations, as i did in my patch.
>
> Right, but restricting stage-1 output to VA_BITS doesn't make sense;
> remember it's not the same kernel writing the stage-1 and stage-2 tables.
>

Yes, if we restrict driver by limiting either one and removing NESTED
altogether, i don't have a problem with this approach.

Regards,
Tirumalesh.

> Will
