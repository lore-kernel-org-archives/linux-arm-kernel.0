From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Apr 2015 21:42:21 +0100
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <55282C1F.3000600@free.fr>
References: <5527B331.5000205@free.fr>
 <20150410114415.GC12732@n2100.arm.linux.org.uk>
 <5527C501.2040808@free.fr>
 <20150410150607.GG12732@n2100.arm.linux.org.uk>
 <5527EC90.9050900@free.fr>
 <20150410160817.GH12732@n2100.arm.linux.org.uk>
 <55282C1F.3000600@free.fr>
Message-ID: <20150410204221.GI12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 10:01:35PM +0200, Mason wrote:
> There is, however, an important difference between loop-based
> delays and timer-based delays; CPU frequencies typically fall
> in the 50-5000 MHz range, while timer frequencies typically
> span tens of kHz up to hundreds of MHz. For example, 90 kHz
> is sometimes provided in multimedia systems (MPEG TS).

Why would you want to use such a slowly clocked counter for something
which is supposed to be able to produce delays in the micro-second and
potentially the nanosecond range?

get_cycles(), which is what the timer based delay is based upon, is
supposed to be a _high resolution counter_, preferably running at
the same kind of speeds as the CPU, though with a fixed clock rate.
It most definitely is not supposed to be in the kHz range.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
