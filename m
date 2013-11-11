From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 11 Nov 2013 15:38:20 +0900
Subject: [PATCH 0/4] arm64: Add audit support
In-Reply-To: <20131108143456.GJ17461@mudshark.cambridge.arm.com>
References: <1383733546-2846-1-git-send-email-takahiro.akashi@linaro.org>
 <20131108143456.GJ17461@mudshark.cambridge.arm.com>
Message-ID: <52807B5C.20300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2013 11:34 PM, Will Deacon wrote:
> On Wed, Nov 06, 2013 at 10:25:42AM +0000, AKASHI Takahiro wrote:
>> This patchset adds audit support on arm64.
>> The implementation is just like in other architectures,
>> and so I think little explanation is needed.
>
> That doesn't mean you can just omit the commit messages!

I will include some commit messages in the next version.

>> I'd like to discuss about the following issues:
>> (issues)
>> * AUDIT_ARCH_*
>>    Why do we need to distiguish big-endian and little-endian? [2/4]
>
> We don't. This is only the case if the syscall ABIs differ between them (for
> AArch32, people mistakenly thought __ARMEB__ was related to AEABI.

I guessed so, but ...

>> * Userspace audit package
>>    There are some missing syscall definitions in lib/aarch64_table.h.
>>    There is no support for AUDIT_ARCH_ARM (I mean LE. armeb is BE).
>
> I did post something over a year ago... did it not get picked up?
>
>    http://permalink.gmane.org/gmane.linux.ports.arm.kernel/165266

Sounds great, but the reality is that AUDIT_ARCH_ARMEB is still used
in the latest v2.3.2, and due to this, ausearch cannot pretty-print
the architecture name in the audit log for LE.

I will ask this in linux-audit ML.

-Takahiro AKASHI

> Will
>
