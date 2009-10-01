From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Oct 2009 14:05:22 +0100
Subject: [PATCH 1/4] Made VMALLOC_END of type unsigned long.
In-Reply-To: <1254394141-26673-1-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1254394141-26673-1-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <20091001130522.GC26910@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2009 at 12:48:55PM +0200, Andreas Fenkart wrote:
> Here it is, rebased against commit
> 7fa07729e439a6184bd824746d06a49cca553f15.
> 
> I added macros simplifying the printout message, as your suggested.
> Patches are now split/merged differently so they describe one logical
> step.
> 
> Unfortunately the macros you suggested trigger a checkpatch.pl
> warning:
> 
> ERROR: Macros with complex values should be enclosed in parenthesis
> #628: FILE: arm/mm/init.c:628:
> +#define MLM(b, t) b, t, ((t) - (b)) >> 20

This is a case where ignoring checkpatch.pl is the right thing to do.
It doesn't know what is trying to be achieved, and is trying to apply
an inappropriate rule.

I'd ignore this warning.
