From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Thu, 28 Jul 2011 14:17:02 +0300
Subject: [PATCH v2] ARM: alignment: Make SIGBUS sent to userspace POSIXly
	correct
In-Reply-To: <1311768636-29582-1-git-send-email-dave.martin@linaro.org>
References: <1311768636-29582-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110728111702.GA22645@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2011 at 01:10:36PM +0100, Dave Martin wrote:
> With the UM_SIGNAL alignment fault mode, no siginfo structure is
> passed to userspace.
> 
> POSIX specifies how siginfo_t should be populated for alignment
> faults, so this patch does just that:
> 
>   * si_signo = SIGBUS
>   * si_code = BUS_ADRALN
>   * si_addr = misaligned data address at which access was attempted
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> v2: si_addr in siginfo_t changed to contain the faulting data
>     access address, not the address of the faulting instruction.
> 
>     This behaviour is consistent with the way other fault signals
>     such as SIGSEGV are already reported, as well as matching the
>     apparent intent of the POSIX sigaction interface.

Acked-by: Kirill A. Shutemov <kirill@shutemov.name>

-- 
 Kirill A. Shutemov
