From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Feb 2015 21:33:46 +0100
Subject: [PATCH v2 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <20150206193859.GP18140@ld-irv-0074>
References: <1422284164-16867-1-git-send-email-maxime.ripard@free-electrons.com>
 <1422284164-16867-2-git-send-email-maxime.ripard@free-electrons.com>
 <20150204111028.2f0bd376@bbrezillon>
 <20150206010835.GB30781@ld-irv-0074>
 <20150206091307.1162b123@bbrezillon>
 <54D4CCEB.5090009@free-electrons.com>
 <20150206193859.GP18140@ld-irv-0074>
Message-ID: <20150206203346.GI2079@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 11:38:59AM -0800, Brian Norris wrote:
> > > An alternative would be to move this part into the read/write_buf
> > > functions, but that's a lot of work...
> > > 
> > 
> > Yeah, indeed. This also has other benefits. As we discussed on IRC, it
> > would allow to support raw writes (i.e. ECC off).
> 
> OK. This is probably a good work item for later. But let's get back on
> point.
> 
> I'd like to see version 2 with the following:
> 
> 1. For sure the jiffies loop needs to be rewritten
> 
> 2. Optionally, the RDDREQ bit should be checked less often, per the
>    datasheet and Boris's comments
> 
> Maxime, would that be OK?

Yep. I actually worked on these two issues just today.

It looks like I blew my boards' bootloader in the process, so it might
take so time.

> Then maybe I can get this into 3.20. Maybe not in my primary -rc1
> pullreq, if we haven't had enough time to look at and test v2, but ASAP.
> Only after than am I likely to take Rob's ARM64 cleanup.

Sounds good, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150206/03925354/attachment.sig>
