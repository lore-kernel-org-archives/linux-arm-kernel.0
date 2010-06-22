From: igawa@mxs.nes.nec.co.jp (Masayuki Igawa)
Date: Tue, 22 Jun 2010 16:40:19 +0900 (JST)
Subject: [PATCH 0/3] makedumpfile: add support for ARM crashdumps
In-Reply-To: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1277188127.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <20100622.164019.11984249.igawa@mxs.nes.nec.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mika.

Thank you for your patches.

I'll check them.

BTW, I'm preparing for makedumpfile-v1.3.6 release now.
So I'll skip merging these patches in this v1.3.6 release.
These patches will be merged in the next release(may be v1.3.7).

Thanks.
-- 
Masayuki Igawa


From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH 0/3] makedumpfile: add support for ARM crashdumps
Date: Tue, 22 Jun 2010 09:59:09 +0300
> Hello,
> 
> This series adds support for ARM kernel crashdumps to makedumpfile. Although,
> kernel support is not yet in mainline, I think that it doesn't hurt to have
> necessary userspace tools available when that happens.
> 
> If someone wants to try, kernel patches can be found:
> 	http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/014230.html
> 
> and kexec-tools already contain ARM crashdump support.
> 
> Regards,
> MW
> 
> Mika Westerberg (3):
>   use ARCH_PFN_OFFSET for pfn_to_paddr/paddr_to_pfn translations
>   page_to_pfn(): use ULONGLONG_MAX to for invalid pfn
>   add ARM crashdump support
> 
>  Makefile       |    4 +-
>  arm.c          |  200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  makedumpfile.c |    7 +-
>  makedumpfile.h |   43 ++++++++++++-
>  4 files changed, 247 insertions(+), 7 deletions(-)
>  create mode 100644 arm.c
> 
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
