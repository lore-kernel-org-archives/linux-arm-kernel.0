From: joel.schopp@amd.com (Joel Schopp)
Date: Mon, 14 Jul 2014 15:38:59 -0500
Subject: [PATCH v6 2/7] arm64: Introduce VA_BITS and translation level
 options
In-Reply-To: <CAOZdJXWCu-zHuQoAUdiieqsKqCfG9BsZariFqQP=NCgQP-zpNA@mail.gmail.com>
References: <000101cf6dc6$3b93d510$b2bb7f30$@samsung.com>
 <CAOZdJXWCu-zHuQoAUdiieqsKqCfG9BsZariFqQP=NCgQP-zpNA@mail.gmail.com>
Message-ID: <53C43FE3.1050008@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I agree that these patches would be very useful.  I just rebased my fix
for a VTTBR_BADDR_MASK bug on one of these patches that could be pulled
out independently.  See
https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010480.html

The original author Jungseok Lee is no longer available to work on
future versions of these patches.  I was thinking that if they didn't
get picked up as they are that with the original author's blessing I
would pick them up and keep them forward ported/resubmitted.  I have an
SOC to test them on.

-Joel

On 07/14/2014 02:53 PM, Timur Tabi wrote:
> On Mon, May 12, 2014 at 4:40 AM, Jungseok Lee <jays.lee@samsung.com> wrote:
>> This patch adds virtual address space size and a level of translation
>> tables to kernel configuration. It facilicates introduction of
>> different MMU options, such as 4KB + 4 levels, 16KB + 4 levels and
>> 64KB + 3 levels, easily.
> Is there a reason why this patch has not yet been picked up?  It
> appears to work just fine, and the change is necessary for ARM SOCs
> that support large amounts of memory.  It seems weird that after so
> many versions, reviews, and ACKs, that it still not in linux-next.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
