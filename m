From: cl@linux.com (Christoph Lameter)
Date: Thu, 23 Sep 2010 15:32:50 -0500 (CDT)
Subject: [PATCH 6/8] ptp: Added a clock that uses the eTSEC found on the
	MPC85xx.
In-Reply-To: <20100923214359.3f287b11@lxorguk.ukuu.org.uk>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<57b64051c816dc9cb856bbb9f38fc901c9d3d651.1285261535.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231348150.2962@router.home>
	<20100923214359.3f287b11@lxorguk.ukuu.org.uk>
Message-ID: <alpine.DEB.2.00.1009231527330.7522@router.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Sep 2010, Alan Cox wrote:

> > Please do not introduce useless additional layers for clock sync. Load
> > these ptp clocks like the other regular clock modules and make them sync
> > system time like any other clock.
>
> I don't think you understand PTP. PTP has masters, a system can need to
> be honouring multiple conflicting masters at once.

The upshot of it all has to be some synchronized notion of time regardless
of how many other things are going on under the hood. And the spec here
suggests a hardware able to generate periodic accurate events that can be
used to sync system time.

> > Really guys: I want a PTP solution! Now! And not some idiotic additional
> > kernel layers that just pass bits around because its so much fun and
> > screws up clock accurary in due to the latency noise introduced while
> > having so much fun with the bits.
>
> There are some interesting complications in putting a PTP sync
> interface in kernel.

If the PTP logic internally has to juggle multiple clocks then that is a
complication for the driver ok. In any case the driver ultimately has to
provide *one* source of time for the system to sync to.
