From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Fri, 4 Jun 2010 09:43:31 +0800
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <20100604000605.GF4720@trinity.fluff.org>
References: <1275479804.137633.565764505843.0.gpush@pororo>
	<20100603110533.GB7127@n2100.arm.linux.org.uk>
	<20100604000605.GF4720@trinity.fluff.org>
Message-ID: <201006040943.32527.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

> As an addendum to Russell's comments, we need to specify the behaviour
> with resepect to what happens about clock stabilisation as well, if the
> clock we enabled takes time to stabilise, then should we wait?

Yes. If we're going to the effort of ensuring that the clock is enabled before 
clk_enable returns, we should also guarantee that the clock is fully-
functional.

If that takes some time, then that's just the cost of ensuring correct 
behaviour.

Cheers,


Jeremy
