From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Thu, 09 Apr 2015 10:07:05 -0700
Subject: "tcp: refine TSO autosizing" causes performance regression on Xen
In-Reply-To: <alpine.DEB.2.02.1504091729160.7690@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1504091344260.7690@kaball.uk.xensource.com>
 <1428596218.25985.263.camel@edumazet-glaptop2.roam.corp.google.com>
 <alpine.DEB.2.02.1504091729160.7690@kaball.uk.xensource.com>
Message-ID: <1428599225.25985.267.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-04-09 at 17:36 +0100, Stefano Stabellini wrote:

> A very big difference:
> 
> echo 262144 > /proc/sys/net/ipv4/tcp_limit_output_bytes
> brings us much closer to the original performance, the slowdown is just
> 8%

Cool.

> 
> echo 1048576 > /proc/sys/net/ipv4/tcp_limit_output_bytes
> fills the gap entirely, same performance as before "refine TSO
> autosizing"


Sure, this basically disables TCP Small Queue and select the opposite :

Favor single flow throughput and huge latencies (bufferbloat)


> 
> 
> What would be the next step for here?  Should I just document this as an
> important performance tweaking step for Xen, or is there something else
> we can do?

I guess this is a reasonable choice.

Note that /proc/sys/net/ipv4/tcp_limit_output_bytes is already
documented.
