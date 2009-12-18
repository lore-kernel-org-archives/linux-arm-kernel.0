From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Dec 2009 10:00:02 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors
In-Reply-To: <20091217193210.GD362@shareable.org>
References: <20091217193210.GD362@shareable.org>
Message-ID: <1261130402.13520.1.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-12-17 at 19:32 +0000, Jamie Lokier wrote:
> Leif Lindholm wrote:
> > +     printk(KERN_INFO "SWP{B} emulation: access caused memory abort!\n");
> > +     arm_notify_die("Illegal memory access", regs, &info, 0, 0);
> 
> > +     if (address & 0x3) {
> > +             /* SWP to unaligned address not permitted */
> > +             printk(KERN_INFO "SWP instruction on unaligned pointer!\n");
> > +             return -EFAULT;
> > +     }
> 
> These printks look like an easy local denial of service.  They should
> be rate limited.

pr_debug() may be a better choice.

-- 
Catalin
