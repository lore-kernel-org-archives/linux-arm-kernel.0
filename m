From: wangnan0@huawei.com (Wangnan (F))
Date: Tue, 22 Dec 2015 22:16:42 +0800
Subject: [BUG REPORT]: ARM64: perf: System hung in perf test
In-Reply-To: <20151221140104.GQ23092@arm.com>
References: <5677F6E3.9050902@huawei.com> <20151221140104.GQ23092@arm.com>
Message-ID: <56795B4A.2000404@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/21 22:01, Will Deacon wrote:
> On Mon, Dec 21, 2015 at 08:56:03PM +0800, Wangnan (F) wrote:
>
[SNIP]
>>   # /perf test -v signal
>>   17: Test breakpoint overflow signal handler                  :
>>   --- start ---
>>   test child forked, pid 792
>>   count1 11, count2 11, overflow 11
>>   failed: RF EFLAG recursion issue detected
>>   failed: wrong overflow hit
>>   failed: wrong count for bp2
>>   test child finished with -1
>>   ---- end ----
>>   Test breakpoint overflow signal handler: FAILED!
> ... and this sounds like the perf tool expecting to single-step over
> signal handlers, whereas (on arm64) we deliberately single-step into
> them, so you can run into a loop for this case.

Could you please provide me more information? Do you think it is
a kernel bug and should be fixed? Or it is an invalid testcase for
aarch64?

Thank you.

> Will
