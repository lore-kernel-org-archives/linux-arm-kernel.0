From: fweimer@redhat.com (Florian Weimer)
Date: Fri, 9 Sep 2016 16:39:14 +0200
Subject: [RFC PATCH 0/5] arm64: Signal context expansion
In-Reply-To: <1473430576-20792-1-git-send-email-Dave.Martin@arm.com>
References: <1473430576-20792-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <dad2e7cc-f8cb-4e33-99c7-66effa7a6f5e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2016 04:15 PM, Dave Martin wrote:
> This new record can be added in sigframe.__reserved[] if there is a
> need to allocate extra space beyond the standard signal frame.  The
> extra block of memory referenced by extra_context can then be parsed in
> the same way as sigcontext.__reserved[].  Old code should just ignore
> the whole thing as an unrecognised record.  To maintain backward
> compatibility, signal context records defined today are always placed
> directly in __reserved[], never in the block referenced by
> extra_context.

Do you add this extra information only if the stack is sufficiently large?

x86_64 adds the new information even for small stacks set up with 
sigaltstack, leading to memory corruption on bleeding-edge hardware:

   <https://bugzilla.kernel.org/show_bug.cgi?id=153531>

Thanks,
Florian
