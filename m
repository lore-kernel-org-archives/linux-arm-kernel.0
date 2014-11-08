From: pbonzini@redhat.com (Paolo Bonzini)
Date: Sat, 08 Nov 2014 08:28:50 +0100
Subject: [PATCH v13 6/7] arm: KVM: dirty log read write protect support
In-Reply-To: <545D21BE.2020203@samsung.com>
References: <1415320848-13813-1-git-send-email-m.smarduch@samsung.com>
 <1415320848-13813-7-git-send-email-m.smarduch@samsung.com>
 <545C76E9.5090700@redhat.com> <545D21BE.2020203@samsung.com>
Message-ID: <545DC632.6020002@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/11/2014 20:47, Mario Smarduch wrote:
>> That can happen if the error occurred in the final
>> copy to userspace, after page tables have been modified.
>
> Upon error return userspace should terminate logging, error out whether
> used for migration or other use cases, with some stale spte TLBs cached
> read/write, which doesn't appear to be harmful.

Fair enough; for x86 I elected to always do the TLB flush, but you can
do it differently.  Perhaps add a comment with the above paragraph, thouhg.

> But you mention 'final copy' which makes me think I'm missing something?

I meant final copy before leaving the function.

Paolo
