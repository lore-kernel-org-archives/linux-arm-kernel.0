From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Jan 2014 18:04:43 +0000
Subject: [PATCH 4/6] arm64: add EFI stub
In-Reply-To: <1389392950-22457-5-git-send-email-msalter@redhat.com>
References: <1389392950-22457-1-git-send-email-msalter@redhat.com>
 <1389392950-22457-5-git-send-email-msalter@redhat.com>
Message-ID: <20140122180443.GF8065@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 10:29:08PM +0000, Mark Salter wrote:
> +ENTRY(efi_stub_entry)
> +       stp     x29, x30, [sp, #-32]!
> +
> +       /*
> +        * Call efi_entry to do the real work.
> +        * x0 and x1 are already set up by firmware. Current runtime
> +        * address of image is calculated and passed via *image_addr.
> +        *
> +        * unsigned long efi_entry(void *handle,
> +        *                         efi_system_table_t *sys_table,
> +        *                         unsigned long *image_addr) ;
> +        */
> +       adrp    x8, _text
> +        add    x8, x8, #:lo12:_text

Possibly some minor whitespace corruption (or it's our email server).

-- 
Catalin
