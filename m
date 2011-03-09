From: bill_carson@126.com (rocky)
Date: Wed, 9 Mar 2011 10:49:01 +0800 (CST)
Subject: Question about free_pgd_slow ?
In-Reply-To: <AANLkTikyeE=YEJ03-zewU9i_aMfG=A9kOKdpe4Fywax6@mail.gmail.com>
References: <AANLkTikyeE=YEJ03-zewU9i_aMfG=A9kOKdpe4Fywax6@mail.gmail.com>
	<79b2dce2.4b84.12e5ae30c01.Coremail.bill_carson@126.com>
	<AANLkTi=obVFm=cwDyUCXQvEK3rDYberc9YWRVkv6_qZ=@mail.gmail.com>
	<14bf5cc1.490f.12e858767f5.Coremail.bill_carson@126.com>
Message-ID: <13b7a6f5.3213.12e98847729.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At 2011-03-07 22:44:58?"Rabin Vincent" <rabin@rab.in> wrote: >2011/3/5 rocky <bill_carson@126.com>: >pgd_free() on the other hand is safe because it's called when we've >switched away from this mm, and the page table is no longer in use >(mm->mm_count == 0). > >Have a look at exit_mm(), which increases the mm_count before calling >mm_put(), and finish_task_switch(), which does the mmdrop().

crystal clear:)
your explanation DOES make sense

I can say when mm->mm_count ==0 , current_thread_info is not the thread info corresponding with mm used in mmdrop()

currently I am working on hugetlb for ARM
I put huge page table in thread_info when calling pgd_alloc
and wants to free it in pgd_free which is doomed to fail.
now I move those cookies into mm_struct , definitely not right place.
but I cannot find a desired place!

Thanks Rabin

rocky













-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110309/41fbdff1/attachment.html>
