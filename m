From: qiuxishi@huawei.com (Xishi Qiu)
Date: Fri, 27 Nov 2015 09:52:16 +0800
Subject: [PATCH] arm64: calculate the various pages number to show
In-Reply-To: <20151126154926.GG32343@leverpostej>
References: <1448458872-39897-1-git-send-email-zhongjiang@huawei.com>
 <20151125150448.GD12434@leverpostej> <56571FBC.2020300@huawei.com>
 <20151126154926.GG32343@leverpostej>
Message-ID: <5657B750.6080908@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/11/26 23:49, Mark Rutland wrote:

> On Thu, Nov 26, 2015 at 11:05:32PM +0800, zhong jiang wrote:
>> On 2015/11/25 23:04, Mark Rutland wrote:
>>> On Wed, Nov 25, 2015 at 09:41:12PM +0800, zhongjiang wrote:
>>>> This patch add the interface to show the number of 4KB or 64KB page,
>>>> aims to statistics the number of different types of pages.
>>>
>>> What is this useful for? Why do we want it?
>>>
>>> What does it account for, just the swapper?
>>>
>>
>> The patch is wirtten when I was in backport set_memory_ro. It can be used to
>> detect whether there is a large page spliting and merging. large page will
>> significantly reduce the TLB miss, and improve the system performance.
> 
> Ok, but typically the user isn't going to be able to do much with this
> information. It feels more like something that should be in the page
> table dump code (where we can calculate the values as we walk the
> tables).
> 
> What is it intended to account for?
> 
> The entire swapper?
> 
> Just the linear mapping?

Hi Mark,

x86 has this information when cat /proc/meminfo, so how about just
like x86 to show it?

Thanks,
Xishi Qiu 
