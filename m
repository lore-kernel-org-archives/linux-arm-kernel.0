From: gengdongjiu@huawei.com (gengdongjiu)
Date: Thu, 30 Nov 2017 19:32:25 +0800
Subject: [PATCH] KVM: arm64: handle the translation table walk RAS error
In-Reply-To: <20171129132212.GA10563@lvm>
References: <1511988524-30240-1-git-send-email-gengdongjiu@huawei.com>
 <20171129132212.GA10563@lvm>
Message-ID: <e7b232bb-0f00-f250-cf63-2da04b9360f8@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/11/29 21:22, Christoffer Dall wrote:
>> table, but it already unmap by host APEI driver, then
>> generate stage2 data abort again, so this will lead to dead
>> loop.
> Why does it lead to a loop? If the host has marked a page as unusable,
> shouldn't the guest stage 1 page table be backed by a different page
> when the fault happens on stage 2?

Thanks a lot for the question and reply, I will test more to confirm it.

> 
