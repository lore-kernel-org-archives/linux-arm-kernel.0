From: davem@davemloft.net (David Miller)
Date: Mon, 12 Feb 2018 10:39:56 -0500 (EST)
Subject: [PATCH net v4 02/13] net/8390: Fix msg_enable patch snafu
In-Reply-To: <f697da2b2513e025688f6c48088536060575a249.1518397634.git.fthain@telegraphics.com.au>
References: <cover.1518397634.git.fthain@telegraphics.com.au>
 <f697da2b2513e025688f6c48088536060575a249.1518397634.git.fthain@telegraphics.com.au>
Message-ID: <20180212.103956.1262868827217051631.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Sun, 11 Feb 2018 22:08:43 -0500 (EST)

> The lib8390 module parameter 'msg_enable' doesn't do anything useful:
> it causes an ancient version string to be logged.

Not true.

You need to look at the various netif_*() et al. message logging
interfaces, they check "p->msg_enable" to determine which messages to
print.

I'm not applying this, sorry.

Just for the record, I consider these kinds of ancient driver cleanups
painful to review, and unless they allow some ugly global kernel API
to be improved or removed such changes have very little gain.

In fact, most of them have a good chance to break things.

It is especially a dubious sequence when you cluster so many of these
things together into a large patch series.

If you are really serious about fixing real bugs, post these one at a
time, very slowly, for us to review properly and apply.

Thank you.
