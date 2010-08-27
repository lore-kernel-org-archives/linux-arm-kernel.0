From: imp@bsdimp.com (M. Warner Losh)
Date: Fri, 27 Aug 2010 09:35:21 -0600 (MDT)
Subject: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
In-Reply-To: <20100827140205.GA3293@riccoc20.at.omicron.at>
References: <20100827075727.GA3818@riccoc20.at.omicron.at>
	<20100827134154.50eef56c@lxorguk.ukuu.org.uk>
	<20100827140205.GA3293@riccoc20.at.omicron.at>
Message-ID: <20100827.093521.467748298504420477.imp@bsdimp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In message: <20100827140205.GA3293@riccoc20.at.omicron.at>
            Richard Cochran <richardcochran@gmail.com> writes:
: On Fri, Aug 27, 2010 at 01:41:54PM +0100, Alan Cox wrote:
: > > The master node in a PTP network probably takes its time from a
: > > precise external time source, like GPS. The GPS provides a 1 PPS
: > > directly to the PTP clock hardware, which latches the PTP hardware
: > > clock time on the PPS edge. This provides one sample as input to a
: > > clock servo (in the PTPd) that, in turn, regulates the PTP clock
: > > hardware.
: > 
: > A PTP clock is TAI, Unix time is UTC.
: 
: But TAI and UTC progress at the same rate, and UTC differs from TAI by
: a constant offset. In fact, the needed conversion is provided by the
: protocol, so it is not hard to take a 1 PPS from GPS and set the PTP
: clock to TAI.

Except for leap seconds, this is true.   However, Unix time isn't UTC
either.  Unix time is UTC that pretends leap seconds just don't
exist.  POSIX enshrined this long ago, and nobody is going to change
that any time soon.

I don't believe IEEEv2 propagates leap seconds, does it?

Warner
