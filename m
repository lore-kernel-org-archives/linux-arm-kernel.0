From: sstabellini@kernel.org (Stefano Stabellini)
Date: Fri, 6 Nov 2015 14:34:28 +0000 (GMT)
Subject: [PATCH 1/3] xen/arm: introduce xen_read_wallclock
In-Reply-To: <20151106122641.GC23038@leverpostej>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <1446743385-12848-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20151106122641.GC23038@leverpostej>
Message-ID: <alpine.DEB.2.02.1511061434020.23825@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Nov 2015, Mark Rutland wrote:
> > +	delta = arch_timer_read_counter();	/* time since system boot */
> > +	delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
> 
> The arch counter value is not a number of nanoseconds (unless CNTFRQ
> reads as 1000000), so this doesn't look right; the units don't match.

That was a bad mistake. Thanks for catching it!
