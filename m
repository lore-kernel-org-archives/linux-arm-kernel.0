From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Nov 2015 12:26:42 +0000
Subject: [PATCH 1/3] xen/arm: introduce xen_read_wallclock
In-Reply-To: <1446743385-12848-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <1446743385-12848-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20151106122641.GC23038@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	delta = arch_timer_read_counter();	/* time since system boot */
> +	delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;

The arch counter value is not a number of nanoseconds (unless CNTFRQ
reads as 1000000), so this doesn't look right; the units don't match.

Thanks,
Mark.
