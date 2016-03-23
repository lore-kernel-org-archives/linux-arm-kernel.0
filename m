From: vbabka@suse.cz (Vlastimil Babka)
Date: Wed, 23 Mar 2016 09:26:43 +0100
Subject: Suspicious error for CMA stress test
In-Reply-To: <20160323044407.GB4624@js1304-P5Q-DELUXE>
References: <56E2FB5C.1040602@suse.cz>
 <20160314064925.GA27587@js1304-P5Q-DELUXE> <56E662E8.700@suse.cz>
 <20160314071803.GA28094@js1304-P5Q-DELUXE> <56E92AFC.9050208@huawei.com>
 <20160317065426.GA10315@js1304-P5Q-DELUXE> <56EA77BC.2090702@huawei.com>
 <56EAD0B4.2060807@suse.cz>
 <CAAmzW4MNdFHSSTpCfWqy7oDtkR_Hfu2dZa_LW97W8J5vr5m4tg@mail.gmail.com>
 <56EC0C41.70503@suse.cz> <20160323044407.GB4624@js1304-P5Q-DELUXE>
Message-ID: <56F25343.8010100@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2016 05:44 AM, Joonsoo Kim wrote:
>>
>> Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
>> Link: https://lkml.org/lkml/2016/3/2/280
>> Reported-by: Hanjun Guo <guohanjun@huawei.com>
>> Debugged-by: Laura Abbott <labbott@redhat.com>
>> Debugged-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Cc: <stable@vger.kernel.org> # 3.18+
>> ---
>>   mm/page_alloc.c | 46 +++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 33 insertions(+), 13 deletions(-)
>
> Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Thanks for taking care of this issue!.

Thanks for the review. But I'm now not sure whether we push this to 
mainline+stable now, and later replace with Lucas' approach, or whether 
that approach would be also suitable and non-disruptive enough for stable?
