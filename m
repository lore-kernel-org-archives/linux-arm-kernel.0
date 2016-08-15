From: james.morse@arm.com (James Morse)
Date: Mon, 15 Aug 2016 17:45:43 +0100
Subject: [stable:PATCH 1/2] arm64: kernel: Save and restore addr_limit
 on exception entry
In-Reply-To: <20160814155432.GA27321@kroah.com>
References: <1471025480-10394-1-git-send-email-james.morse@arm.com>
 <20160814155432.GA27321@kroah.com>
Message-ID: <57B1F1B7.2090003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 14/08/16 16:54, Greg KH wrote:
> On Fri, Aug 12, 2016 at 07:11:19PM +0100, James Morse wrote:
>> commit e19a6ee2460bdd0d0055a6029383422773f9999a upstream.
>>
>> If we take an exception while at EL1, the exception handler inherits
>> the original context's addr_limit value. To be consistent always reset
>> addr_limit and PSTATE.UAO on (re-)entry to EL1. This prevents accidental
>> re-use of the original context's addr_limit.
>>
>> Based on a similar patch for arm from Russell King.
>>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> [ backport to stop perf misusing inherited addr_limit.
>>   Removed code interacting with UAO and the irqstack ]
>> Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=822
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Cc: <stable@vger.kernel.org> #4.1
> 
> Fails to apply to 4.4-stable, can you provide a backport for both of
> these to that tree if you want them there?

Sorry - that is what I was trying to do!

v4.4:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/448685.html

v4.1 (this one):
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/448684.html


Did I mess something up in the cc/sign-off area?


Thanks,

James
