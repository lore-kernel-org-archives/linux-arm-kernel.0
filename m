From: vbabka@suse.cz (Vlastimil Babka)
Date: Fri, 18 Mar 2016 13:29:26 +0100
Subject: Suspicious error for CMA stress test
In-Reply-To: <20160317065426.GA10315@js1304-P5Q-DELUXE>
References: <56DD38E7.3050107@huawei.com> <56DDCB86.4030709@redhat.com>
 <56DE30CB.7020207@huawei.com> <56DF7B28.9060108@huawei.com>
 <CAAmzW4NDJwgq_P33Ru_X0MKXGQEnY5dr_SY1GFutPAqEUAc_rg@mail.gmail.com>
 <56E2FB5C.1040602@suse.cz> <20160314064925.GA27587@js1304-P5Q-DELUXE>
 <56E662E8.700@suse.cz> <20160314071803.GA28094@js1304-P5Q-DELUXE>
 <56E92AFC.9050208@huawei.com> <20160317065426.GA10315@js1304-P5Q-DELUXE>
Message-ID: <56EBF4A6.5010308@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2016 07:54 AM, Joonsoo Kim wrote:
> On Wed, Mar 16, 2016 at 05:44:28PM +0800, Hanjun Guo wrote:
>> On 2016/3/14 15:18, Joonsoo Kim wrote:
>>
>> Hmm, this one is not work, I still can see the bug is there after applying
>> this patch, did I miss something?
>
> I may find that there is a bug which was introduced by me some time
> ago. Could you test following change in __free_one_page() on top of
> Vlastimil's patch?
>
> -page_idx = pfn & ((1 << max_order) - 1);
> +page_idx = pfn & ((1 << MAX_ORDER) - 1);

I think it wasn't a bug in the context of 3c605096d31, but it certainly Does 
become a bug with my patch, so thanks for catching that.

Actually I've earlier concluded that this line is not needed@all, and can 
lead to smaller code, and enable even more savings. But I'll leave that after 
the fix that needs to go to stable.

> Thanks.
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
>
