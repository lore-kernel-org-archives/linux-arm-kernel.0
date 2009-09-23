From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Wed, 23 Sep 2009 14:48:16 +0300
Subject: [PATCH v4, REBASED 1/2] ARM: Pass IFSR register to
	do_PrefetchAbort()
In-Reply-To: <00ae0c0830ca659709d80e56e8e87b636c32fcf6.1253616961.git.kirill@shutemov.name>
References: <00ae0c0830ca659709d80e56e8e87b636c32fcf6.1253616961.git.kirill@shutemov.name>
Message-ID: <cc557aab0909230448r6a4ff709k8720155d9389ceae@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2009 at 2:00 PM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> Instruction fault status register, IFSR, was introduced on ARMv6 to
> provide status information about the last insturction fault. It
> needed for proper prefetch abort handling.
>
> Now we have three prefetch abort model:
>
> ?* legacy - for CPUs before ARMv6. They doesn't provide neither
> ? ?IFSR nor IFAR. We simulate IFSR with section translation fault
> ? ?status for them to generalize code;
> ?* ARMv6 - provides IFSR, but not IFAR;
> ?* ARMv7 - provides both IFSR and IFAR.
>
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>

Any feedback?
