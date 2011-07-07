From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 09:15:37 +0100
Subject: [PATCH] remove unnecessary cache flush on v6 copypage
In-Reply-To: <CAN_5kQDTweB2GLvwgjN+BQuqnhFUp+MOcQr=ZW=8C6XSsC8XtA@mail.gmail.com>
References: <CAN_5kQDTweB2GLvwgjN+BQuqnhFUp+MOcQr=ZW=8C6XSsC8XtA@mail.gmail.com>
Message-ID: <20110707081537.GG8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 07:19:59PM -0700, heechul Yun wrote:
> ARM: mm: remove unnecessary cache flush on v6 copypage
> 
> Signed-off-by: Heechul Yun <heechul@illinois.edu>
> --
> arch/arm/mm/copypage-v6.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> index bdba6c6..63cca00 100644
> --- a/arch/arm/mm/copypage-v6.c
> +++ b/arch/arm/mm/copypage-v6.c
> @@ -41,7 +41,6 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
>        kfrom = kmap_atomic(from, KM_USER0);
>        kto = kmap_atomic(to, KM_USER1);
>        copy_page(kto, kfrom);
> -       __cpuc_flush_dcache_area(kto, PAGE_SIZE);
>        kunmap_atomic(kto, KM_USER1);
>        kunmap_atomic(kfrom, KM_USER0);
>  }

Patch looks good, except that it's whitespace damaged (the tabs are
replaced by spaces) which makes it hard to apply.  Could you try to
sort that out.  Documentation/email-clients.txt in the kernel tree
may help with that.

I assume Catalin will (eventually) provide an ack - and at that point
please submit it (in non-whitespace damaged form) to the patch system,
thanks.
