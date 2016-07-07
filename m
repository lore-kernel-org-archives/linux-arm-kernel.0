From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 7 Jul 2016 12:35:02 -0600
Subject: [PATCH V2 01/10] Documentation: dt-bindings: mailbox: tegra: Add
 binding for HSP mailbox
In-Reply-To: <20160707181356.GA6864@kickseed.nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-2-josephl@nvidia.com>
 <20160707181356.GA6864@kickseed.nvidia.com>
Message-ID: <577EA0D6.9020308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 12:13 PM, Sivaram Nair wrote:
> On Tue, Jul 05, 2016 at 05:04:22PM +0800, Joseph Lo wrote:
>> Add DT binding for the Hardware Synchronization Primitives (HSP). The
>> HSP is designed for the processors to share resources and communicate
>> together. It provides a set of hardware synchronization primitives for
>> interprocessor communication. So the interprocessor communication (IPC)
>> protocols can use hardware synchronization primitive, when operating
>> between two processors not in an SMP relationship.

>> diff --git a/include/dt-bindings/mailbox/tegra186-hsp.h b/include/dt-bindings/mailbox/tegra186-hsp.h

>> +#define HSP_MBOX_TYPE_DB 0x0
>> +#define HSP_MBOX_TYPE_SM 0x1
>> +#define HSP_MBOX_TYPE_SS 0x2
>> +#define HSP_MBOX_TYPE_AS 0x3
>> +
>> +#define HSP_DB_MASTER_CCPLEX 17
>> +#define HSP_DB_MASTER_BPMP 19
>> +
>> +#define HSP_MBOX_ID(type, ID) \
>> +		(HSP_MBOX_TYPE_##type << 16 | ID)
>
> It will be nicer if you avoid the macro glue magic '##' for 'type'. I
> would also suggest to use braces around 'type' and 'ID'.

This technique been used without issue in quite a few other places 
without issue, and has the benefit of simplifying the text wherever the 
macro is used. What issue do you foresee?

BTW, if this patch does need reposting, I'd suggest s/ID/id/ since macro 
parameters are usually lower-case.
