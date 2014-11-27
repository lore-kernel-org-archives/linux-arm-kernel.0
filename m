From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Nov 2014 10:03:06 +0000
Subject: [PATCH] arm: cacheflush: get rid of restarting block
In-Reply-To: <005b01d009f6$f3c6a0f0$db53e2d0$@min@lge.com>
References: <1416928737-29723-1-git-send-email-vladimir.murzin@arm.com>
 <005b01d009f6$f3c6a0f0$db53e2d0$@min@lge.com>
Message-ID: <20141127100306.GA20649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 04:02:24AM +0000, Chanho Min wrote:
> > -----Original Message-----
> > From: Vladimir Murzin [mailto:vladimir.murzin at arm.com]
> > Sent: Wednesday, November 26, 2014 12:19 AM
> > To: linux-arm-kernel at lists.infradead.org; linux at arm.linux.org.uk
> > Cc: chanho.min at lge.com; will.deacon at arm.com; stable at vger.kernel.org
> > Subject: [PATCH] arm: cacheflush: get rid of restarting block
> > 
> > We cannot restart cacheflush safely if a process provides user-defined
> > signal handler and signal is pending. In this case -EINTR is returned
> > and it is expected that process re-invokes syscall. However, there are
> > a few problems with that:
> >  * looks like nobody bothers checking return value from cacheflush
> >  * but if it did, we don't provide the restart address for that, so the
> >    process has to use the same range again
> >  * ...and again, what might lead to looping forever
> > 
> > So, remove cacheflush restarting code and terminate cache flushing
> > as early as fatal signal is pending.
> > 
> > Cc: stable at vger.kernel.org # 3.12+
> > Reported-by: Chanho Min <chanho.min@lge.com>
> > Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > ---
> > Hi,
> > 
> > There is my proposal for the problem reported in [1]. Since that
> > thread has not been progressing much, I'm addressing the problem in
> > separate patch.
> > 
> > Comments?
> Thanks, We hope this to be applied.

Ok, good. In which case, can you put it into the patch system please,
Vladimir?

Will
