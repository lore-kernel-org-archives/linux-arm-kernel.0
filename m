From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jun 2011 22:36:56 +0100
Subject: [RFC 1/2] ARM:Tegra: Device Tree Support: Initialize the audio
	card from the device tree.
In-Reply-To: <20110602160445.GA8373@ponder.secretlab.ca>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205706.21000.34832.stgit@riker>
	<BANLkTi=NMjBjWVv_o3PocejhgGr8TdG+1Q@mail.gmail.com>
	<BANLkTi=PtEhxxmZo2DqvmySCmnEd3LbezQ@mail.gmail.com>
	<BANLkTikWpiY_o27OF-Jxvq7iPeWzrAYOsQ@mail.gmail.com>
	<20110602160445.GA8373@ponder.secretlab.ca>
Message-ID: <20110602213656.GB10532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 10:04:45AM -0600, Grant Likely wrote:
> Right now we can't do dynamic registration for on-chip devices in a
> lot of cases because we don't have the infrastructure to hook up the
> associated struct clks.

I've been wondering about this, and I don't see it as a blocking problem
as you seem to be.

I assume platform devices have stable names when they're created from
the device tree?  If yes, there's no problem having the DT start to
describe the SoC specific devices _today_ - all that the clk API using
clkdev requires is a stable device name.
