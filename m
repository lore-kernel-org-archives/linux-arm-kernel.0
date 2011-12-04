From: sven@narfation.org (Sven Eckelmann)
Date: Sun, 04 Dec 2011 22:49:10 +0100
Subject: [PATCHv5] atomic: add *_dec_not_zero
In-Reply-To: <20111204213316.GB14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
 <20111204213316.GB14542@n2100.arm.linux.org.uk>
Message-ID: <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 December 2011 21:33:16 Russell King - ARM Linux wrote:
[...]
> > +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL, 0LL)
> 
> I think this is rather silly - all these definitions are very similar to
> each other.  Is there really no way to put this into include/linux/atomic.h,
> maybe as something like:
> 
> #ifndef atomic64_dec_not_zero
> #define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> #endif
> 
> and avoid having to add essentially the same definition to 12 individual
> files?
> 
> Architectures which want to override it can do by the following:
> 
> #define atomic64_dec_not_zero		atomic64_dec_not_zero
> 
> which won't have any effect on C nor asm code.

 * https://lkml.org/lkml/2011/5/8/15
 * https://lkml.org/lkml/2011/5/8/16
 * https://lkml.org/lkml/2011/5/8/321

Kind regards,
	Sven
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111204/28763fec/attachment.sig>
