From: rabin@rab.in (Rabin Vincent)
Date: Fri, 19 Nov 2010 21:39:29 +0530
Subject: [PATCH 1/6] ARM: ensure sched_clock() and children are notrace
In-Reply-To: <AANLkTik9Wv2p9-=X3roJut3A3KLD1D7UWOB795edjHAX@mail.gmail.com>
References: <1289067954-5080-1-git-send-email-rabin@rab.in>
	<AANLkTik9Wv2p9-=X3roJut3A3KLD1D7UWOB795edjHAX@mail.gmail.com>
Message-ID: <20101119160849.GA21870@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Nov 6, 2010 at 11:55 PM, Rabin Vincent <rabin@rab.in> wrote:
> > Include sched.h in the files implementing sched_clock() and ensure that
> > any functions called from sched_clock() have the notrace annotation.

On Sat, Nov 13, 2010 at 12:14:51AM +0530, Rabin Vincent wrote:
> CC'd some mach maintainers.  I can split this up if needed,
> since these bits can be applied independently from the rest
> of the patches in the series.

I've split it up anyway, since tegra and nomadik have since fixed it
themselves while reworking their sched_clock() implementations (and
there are probably others who need to do this), and I missed a couple of
functions in omap and u300 in the first patch.
