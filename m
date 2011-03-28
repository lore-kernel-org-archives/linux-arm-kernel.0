From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 28 Mar 2011 19:02:55 +0100
Subject: [PATCH 2/2] regulator: Propagate uA_load requirements up supply
	chain
In-Reply-To: <1301326482-6547-3-git-send-email-collinsd@codeaurora.org>
References: <1301326482-6547-1-git-send-email-collinsd@codeaurora.org>
	<1301326482-6547-3-git-send-email-collinsd@codeaurora.org>
Message-ID: <20110328180255.GA28494@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 08:34:42AM -0700, David Collins wrote:
> regulator_set_optimum_mode currently only determines the load
> on the specified regulator.  Physically however, this current
> must be provided by regulators further up the supply chain.
> Add code to handle uA_load propagation up through the regulator
> supply chain.

We can't do this - current doesn't map 1:1 through a regulator, the
power consumption will map through but obviously there's a voltage
change involved and the regulators will not be 100% efficient so there
will also be some overhead from the chipld regulator.  The child
regulator needs to do the mapping in a regulator specific fashion.
