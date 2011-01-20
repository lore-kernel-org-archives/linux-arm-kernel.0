From: robert.richter@amd.com (Robert Richter)
Date: Thu, 20 Jan 2011 11:46:06 +0100
Subject: [PATCH] ARM: oprofile: Always allow backtraces
In-Reply-To: <alpine.DEB.2.00.1101201213230.14307@lakka.kapsi.fi>
References: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
	<000101cbb886$582f1480$088d3d80$@deacon@arm.com>
	<20110120095239.GT21401@erda.amd.com>
	<alpine.DEB.2.00.1101201213230.14307@lakka.kapsi.fi>
Message-ID: <20110120104606.GA18297@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.01.11 05:17:16, Ari Kauppi wrote:

> > @@ -91,6 +79,30 @@ static struct frame_tail* user_backtrace(struct frame_tail *tail)
> > 	return buftail[0].fp-1;
> > }
> >
> > +#else
> > +
> > +static int oprofile_arch_init(struct oprofile_operations *ops)
> > +{
> > +	pr_info("oprofile: hardware counters not available\n");
> > +	return -ENODEV;
> > +}
> > +
> > +static void oprofile_arch_exit(void) { }
> 
> I guess you mean oprofile_perf_init and oprofile_perf_exit?

Yes, did not compile test it as my arm cross compile chain was broken.

Maybe we move it to include/linux/oprofile.h.

I also observed some mismatches while using CONFIG_HW_PERF_EVENTS and
CONFIG_PERF_EVENTS, esp. with include/linux/oprofile.h. /arch/sh is
also affected. We need to review this too.

> 
> Also the user_backtrace and frame_tail need to be moved out from the 
> #ifdef.

Yes, thanks.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
