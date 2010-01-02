From: jamie@shareable.org (Jamie Lokier)
Date: Sat, 2 Jan 2010 23:09:07 +0000
Subject: [uClinux-dev] [PATCH] Valid relocation symbol for FLAT format on
	ARM, v2
In-Reply-To: <20100101012645.GB16887@Pogoplug>
References: <20100101012645.GB16887@Pogoplug>
Message-ID: <20100102230906.GB32298@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jun Sun wrote:
> +/* [jsun] new gcc 4.x generates ANCHOR symbols in order to reduce the size
> + * of GOT table for PIC code. It is possible the ANCHOR is placed beyond
> + * the end of data/bss segment up to 4K bytes(12 bits), because ARM allows
> + * negative 12-bit offset. Thus we allow 0x1000 extra in reloc address range.
> + */

Can you provide a small test program and *exact* GCC version and
Binutils version which triggers this?  People have reported using GCC
4.x on ARM uClinux for some time, and I haven't seen complaints
about this problem before.

Thanks,
-- Jamie
