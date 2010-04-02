From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 2 Apr 2010 14:13:46 +0100
Subject: [PATCH] i2c-s3c2410: Remove unconditional 1ms delay on each
	transfer
In-Reply-To: <p2q1b68c6791004020600g283db571gacd0f8b7e4ddaf6@mail.gmail.com>
References: <1270211946-25103-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<p2q1b68c6791004020600g283db571gacd0f8b7e4ddaf6@mail.gmail.com>
Message-ID: <20100402131346.GA28023@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 10:00:52PM +0900, jassi brar wrote:
> On Fri, Apr 2, 2010 at 9:39 PM, Mark Brown

> > + ? ? ? /* first, try busy waiting briefly */
> > + ? ? ? spins = 0;
>           ^^^^^^^^^^^^ ?

Gnargh, this is bit rot from my initial version which didn't have the
fallback for the multi-master case (I don't actually have any hardware
that can trigger that).  As you can see from the fact that I was able to
test this successfully most transfers report idle on the first check
anyway.

Thanks.
