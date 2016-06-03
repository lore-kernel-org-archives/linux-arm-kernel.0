From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 3 Jun 2016 11:51:06 -0700
Subject: [kernel-hardening] [PATCH 2/2] arm: apply more __ro_after_init
In-Reply-To: <1464979224-2085-3-git-send-email-keescook@chromium.org>
References: <1464979224-2085-1-git-send-email-keescook@chromium.org>
 <1464979224-2085-3-git-send-email-keescook@chromium.org>
Message-ID: <20160603185106.GB17076@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 11:40:24AM -0700, Kees Cook wrote:
> Guided by grsecurity's analogous __read_only markings in arch/arm,
> this applies several uses of __ro_after_init to structures that are
> only updated during __init.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm/kernel/cpuidle.c |  2 +-
>  arch/arm/kernel/setup.c   | 10 +++++-----
>  arch/arm/kernel/smp.c     |  2 +-
>  arch/arm/lib/delay.c      |  2 +-
>  arch/arm/mm/mmu.c         |  9 ++-------
>  arch/x86/mm/ioremap.c     |  3 +--

I don't think this x86 file is an arm-specific one :)

That minor nit aside, these patches are a great step forward, are you
going to take them and work to push them upstream, or do you want/need
others to do this?

thanks,

greg k-h
