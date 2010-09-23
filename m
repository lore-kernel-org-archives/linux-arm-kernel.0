From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 23 Sep 2010 21:43:59 +0100
Subject: [PATCH 6/8] ptp: Added a clock that uses the eTSEC found on the
	MPC85xx.
In-Reply-To: <alpine.DEB.2.00.1009231348150.2962@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<57b64051c816dc9cb856bbb9f38fc901c9d3d651.1285261535.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231348150.2962@router.home>
Message-ID: <20100923214359.3f287b11@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Please do not introduce useless additional layers for clock sync. Load
> these ptp clocks like the other regular clock modules and make them sync
> system time like any other clock.

I don't think you understand PTP. PTP has masters, a system can need to
be honouring multiple conflicting masters at once.

> Really guys: I want a PTP solution! Now! And not some idiotic additional
> kernel layers that just pass bits around because its so much fun and
> screws up clock accurary in due to the latency noise introduced while
> having so much fun with the bits.

There are some interesting complications in putting a PTP sync
interface in kernel.
