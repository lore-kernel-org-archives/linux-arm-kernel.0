From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 30 Jul 2015 13:44:44 -0700
Subject: [PATCH v3 01/24] mm: enhance region_is_ram() to
 region_intersects()
In-Reply-To: <20150730204249.GN30479@wotan.suse.de>
References: <20150730165155.33962.64121.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150730165345.33962.80299.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150730204249.GN30479@wotan.suse.de>
Message-ID: <CAPcyv4hywBvt85E6LAznxQaDug17+_YxoyVzhf6fWu+GpsrmKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 1:42 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Thu, Jul 30, 2015 at 12:53:45PM -0400, Dan Williams wrote:
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 2e872f92dbac..84b05ebedb2d 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -369,7 +369,14 @@ static inline int put_page_unless_one(struct page *page)
>>  }
>>
>>  extern int page_is_ram(unsigned long pfn);
>> -extern int region_is_ram(resource_size_t phys_addr, unsigned long size);
>> +
>> +enum {
>> +     REGION_INTERSECTS,
>> +     REGION_DISJOINT,
>> +     REGION_MIXED,
>> +};
>> +
>
> Can you Kdoc'ify this? Part of the reason for the enum request was this
> could be then documented really well. The helper is documented but here
> you can go into more detail about each region intersection.

Given region_intersects() has its own kdoc I'd probably just say "See
region_intersects() for details".
