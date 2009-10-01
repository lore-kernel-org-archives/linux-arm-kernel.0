From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Thu, 1 Oct 2009 10:15:38 +0300
Subject: [PATCH v5 1/2] ARM: Pass IFSR register to do_PrefetchAbort()
In-Reply-To: <b833952fedbf24c4a16e0d79fe78019357e9652b.1253781660.git.kirill@shutemov.name>
References: <b833952fedbf24c4a16e0d79fe78019357e9652b.1253781660.git.kirill@shutemov.name>
Message-ID: <cc557aab0910010015i2e471c13mb4529409b3e68e45@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 11:49 AM, Kirill A. Shutemov
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

Any chances to get it into 2.6.32?
