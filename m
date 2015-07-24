From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 24 Jul 2015 02:16:06 +0200
Subject: [PATCH 3/3] ARM: errata 430973: move !ARCH_MULTIPLATFORM to
 Kconfig
In-Reply-To: <20150723123553.GE7576@n2100.arm.linux.org.uk>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
 <1437612483-30160-4-git-send-email-sre@kernel.org>
 <20150723123553.GE7576@n2100.arm.linux.org.uk>
Message-ID: <20150724001605.GA1453@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On Thu, Jul 23, 2015 at 01:35:53PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 23, 2015 at 02:48:03AM +0200, Sebastian Reichel wrote:
> > Having the !ARCH_MULTIPLATFORM dependency in the Kconfig file results
> > in one option less to think about when configuring the kernel.
> 
> > -#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLATFORM)
> > +#ifdef CONFIG_ARM_ERRATA_430973
> >  	teq	r3, #0x00100000			@ only present in r1p*
> >  	mrceq	p15, 0, r0, c1, c0, 1		@ read aux control register
> >  	orreq	r0, r0, #(1 << 6)		@ set IBE to 1
> 
> NAK.  Please read the mailing list history, I'm not repeating myself
> again on this.  Thanks.

It's a bit hard to search the mailing list history without a bit
more information.

I guess you prefer to just add the !ARCH_MULTIPLATFORM dependency to
the Kconfig entry without removing the additional check in the code?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150724/98dc4c4b/attachment.sig>
