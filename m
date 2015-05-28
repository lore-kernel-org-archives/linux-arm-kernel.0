From: bp@alien8.de (Borislav Petkov)
Date: Thu, 28 May 2015 15:37:06 +0200
Subject: [RFC PATCH] EDAC: Cleanup atomic_scrub mess
In-Reply-To: <20150528123448.GA2067@n2100.arm.linux.org.uk>
References: <1431991481-25684-1-git-send-email-lho@apm.com>
 <1431991481-25684-2-git-send-email-lho@apm.com>
 <20150519170308.GL4641@pd.tnic>
 <CAPw-ZT=mTpt_vz+e=rM5ywK8feNKkJQrpEWg=noRCziJ0840TQ@mail.gmail.com>
 <20150519203336.GP4641@pd.tnic> <20150521180719.GE3689@pd.tnic>
 <20150521181157.GF3689@pd.tnic>
 <20150528123448.GA2067@n2100.arm.linux.org.uk>
Message-ID: <20150528133706.GC31800@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 01:34:49PM +0100, Russell King - ARM Linux wrote:
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks!

I've got all the ACKs now :-)

> 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 45df48ba0b12..325d6f3a596a 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -15,6 +15,8 @@ config ARM
> >  	select CLONE_BACKWARDS
> >  	select CPU_PM if (SUSPEND || CPU_IDLE)
> >  	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
> > +	select EDAC_SUPPORT
> > +	select EDAC_ATOMIC_SCRUB
> 
> I wonder if it would make sense to conditionalise EDAC_SUPPORT on...
> 		if CPU_32v6 || CPU_32v7

I guess you can.

Especially if no newer 32-bit ARM would need the scrubbing anymore.
Disadvantage is, if turns out CPU_32v8 (would there even be v8, no
idea...) and newer would need it after all, you'd have to explicitly
enable it.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
