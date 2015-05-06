From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 6 May 2015 18:57:55 -0400
Subject: [PATCH 02/11] arm/mach-keystone: remove legacy __cpuinit
 sections that crept in
In-Reply-To: <554A4AF6.2060309@oracle.com>
References: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
 <1430174880-27958-3-git-send-email-paul.gortmaker@windriver.com>
 <20150506103704.GJ2067@n2100.arm.linux.org.uk>
 <554A4AF6.2060309@oracle.com>
Message-ID: <20150506225754.GC13001@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH 02/11] arm/mach-keystone: remove legacy __cpuinit sections that crept in] On 06/05/2015 (Wed 10:10) santosh shilimkar wrote:

> On 5/6/2015 3:37 AM, Russell King - ARM Linux wrote:
> >On Mon, Apr 27, 2015 at 06:47:51PM -0400, Paul Gortmaker wrote:
> >>We removed __cpuinit support (leaving no-op stubs) quite some time
> >>ago.  However two crept back in as of commit 5eb3da7246a5b2dfac9f38
> >>("ARM: keystone: Switch over to coherent memory address space")
> >>
> >>Since we want to clobber the stubs too, get these removed now.
> >>
> >>Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >
> >Santosh's email is now: Santosh Shilimkar <ssantosh@kernel.org>
> >
> Thanks Russell.
> 
> 
> >>Cc: linux-arm-kernel at lists.infradead.org
> >>Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> >>---
> >>  arch/arm/mach-keystone/platsmp.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> Paul, Change is fine by me. I can pick this up for 4.2

No need, since I'm forced to keep it here with the actual final stub
removal so that I don't break bisection for people once it goes to
Linus eventually.  I'll add an Ack'd by though.

Thanks,
Paul.
--

> 
> Regards,
> Santosh
