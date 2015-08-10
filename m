From: aph@redhat.com (Andrew Haley)
Date: Mon, 10 Aug 2015 19:19:03 +0100
Subject: [RFC PATCH 01/10] arm64: feature registers: Documentation
In-Reply-To: <55C8E12E.6030305@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
 <1437731037-25795-2-git-send-email-suzuki.poulose@arm.com>
 <20150810160636.GB15394@e104818-lin.cambridge.arm.com>
 <55C8E12E.6030305@arm.com>
Message-ID: <55C8EB17.7090708@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2015 06:36 PM, Suzuki K. Poulose wrote:
> On 10/08/15 17:06, Catalin Marinas wrote:
>> Hi Suzuki,
>>
>> On Fri, Jul 24, 2015 at 10:43:47AM +0100, Suzuki K. Poulose wrote:
>>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>>
>>> Documentation of the infrastructure
>>>
>>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>>
>> The implementation looks fine but I think the main discussion will be
>> around the goal of this feature and the ABI that it introduces. So I'll
>> just write my thoughts on this patch (I could as well have replied to
>> the cover letter).
>>
>> Another question: who's going to use this feature? I know people asked
>> in private but I'd like to have some public statements.
> 
> Right, I am hoping that folks from glibc / JIT / GCC will respond to
> this thread.

We certainly need it for OpenJDK.  We need to know the manufacturer,
part number, revision id, etc.  We already have workarounds in
OpenJDK for various bugs, and we also can generate better code if we
know the exact part.

I note that the REVIDR is not in this patch.  That seems odd, because
it can be used to identify minor revisions.

Andrew.
