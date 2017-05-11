From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 May 2017 14:21:20 +0100
Subject: [PATCH] arm64/cpufeature: don't use mutex in bringup path
In-Reply-To: <20170511131706.cxsntl3dkurj2yja@linutronix.de>
References: <1494508331-31644-1-git-send-email-mark.rutland@arm.com>
 <20170511131706.cxsntl3dkurj2yja@linutronix.de>
Message-ID: <20170511132119.GA31333@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 03:17:06PM +0200, Sebastian Andrzej Siewior wrote:
> On 2017-05-11 14:12:11 [+0100], Mark Rutland wrote:
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index 8a7ff73..5370626 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -223,7 +222,7 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> >  void check_local_cpu_capabilities(void);
> >  
> >  void update_cpu_errata_workarounds(void);
> > -void update_cpu_errata_workarounds_cpuslocked(void);
> > +void update_cpu_errata_workarounds(void);
> >  void __init enable_errata_workarounds(void);
> >  void verify_local_cpu_errata_workarounds(void);
> 
> No need to add update_cpu_errata_workarounds(), it is already there.

Whoops; I'd meant to delete this instance rather than renaming it.

Fixed up locally now.

Mark.
