From: horms@verge.net.au (Simon Horman)
Date: Tue, 7 Mar 2017 07:46:04 +0100
Subject: [PATCH 0/8] ARM: dts: renesas: Remove unit-addresses and regs
 from integrated caches
In-Reply-To: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
References: <1488818443-25196-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170307064603.GD14208@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 05:40:35PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series removes the bogus unit-addresses and reg properties
> from the device nodes representing Cortex-A15/A7 cache controllers.
> 
> Note that the latter were added to remove warnings from dtc when using
> W=1:
> 
>     Warning (unit_address_vs_reg): Node /cache-controller at 0 has a unit name, but no reg property
> 
> In hindsight, adding the reg properties turned out to be the wrong fix.
> Indeed, the Cortex-A15/A7 cache controllers are integrated controllers,
> and thus the device nodes representing them should not have
> unit-addresses or reg properties.
> 
> This series does not have a runtime effect, as Linux doesn't rely much
> on the properties of the cache-controller nodes.
> 
> This series is the arm32 counterpart of "[PATCH 0/2] arm64: dts: renesas:
> Remove unit-addresses and regs from integrated caches", which you've just
> applied.
> 
> Thanks for applying!

Thanks, done.
