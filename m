From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 18 Nov 2015 18:20:03 -0800
Subject: arm64 sched_clock cpu accounting
In-Reply-To: <564CD5A7.8000007@samsung.com>
References: <564CD5A7.8000007@samsung.com>
Message-ID: <564D31D3.5040207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also with tick accounting enabled, and periodic timer HZ set to 1000 no irq time
is reported. That's with running a ping flood - 1200 int/s, not sure why
wouldn't any irq time be reported? The other two modes report irq time as expected.

On 11/18/2015 11:46 AM, Mario Smarduch wrote:
> Hello,
>   I noticed sched clock accounting can be enabled when arch-timer is
> initialized. But arm64 doesn't appear to have 'HAVE_IRQ_TIME_ACCOUNTING'
> selected (as of mainline 4.4-rc1) and IRQ_TIME_ACCOUNTING can't be selected.
> After adding it to arch/arm64/Kconfig, option appears to work fine. Depending on
> need all accounting options are fine, but irq time accounting appears to be most
> preferable.
> 
> Any thoughts? Is it fine to enable it?
> 
> Thanks,
>   Mario
> 
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 
