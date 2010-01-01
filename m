From: vapier@gentoo.org (Mike Frysinger)
Date: Fri, 1 Jan 2010 01:23:48 -0500
Subject: [uClinux-dev] [PATCH] Valid relocation symbol for FLAT format on
	ARM, v2
In-Reply-To: <20100101012645.GB16887@Pogoplug>
References: <20100101012645.GB16887@Pogoplug>
Message-ID: <201001010123.49951.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 December 2009 20:26:45 Jun Sun wrote:

when posting updates, you should put the "v2" and such inside of the "[patch]" 
marker like so: [PATCH v2].  git will remove this automatically when applying.

>  #define	flat_old_ram_flag(flags)	(flags)
> -#define	flat_reloc_valid(reloc, size)	((reloc) <= (size))
> +#define	flat_reloc_valid(reloc, size)	((reloc) <= (size) + 0x1000)
> +/* [jsun] new gcc 4.x generates ANCHOR symbols in order to reduce the size

comments go above the thing they're documenting, not below.  the "[jsun]" is 
also not really useful -- no one who reads this after the fact will have any 
idea what "[jsun]" means.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100101/e17b4972/attachment.sig>
