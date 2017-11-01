From: horms@verge.net.au (Simon Horman)
Date: Wed, 1 Nov 2017 09:40:32 +0100
Subject: [PATCH 0/2] arm64: dts: renesas: r8a77970: Add SMP Support
In-Reply-To: <1509379633-25823-1-git-send-email-geert+renesas@glider.be>
References: <1509379633-25823-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20171101084031.w4lue2g3nh3iuvhx@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 05:07:11PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series enables SMP support on the R-Car V3M SoC, by adding
> the second Cortex-A53 CPU core.  It also adds the performance monitor
> unit, and links it to both CPU cores.
> 
> Note that the PSCI implementation on Eagle may be a preliminary version
> with some familiar quirks:
>   - SMP bringup works, and both CPUs can be used,
>   - Offlining CPU0 crashes the system,
>   - CPU1 can be offlined, but trying to bring it online again crashes
>     the system, too.
> 
> I'm confident these will be fixed in future firmware versions, just like
> on H3/Salvator-X.

I'd like to understand how confident before applying this series.
I have been burnt in the past by enabling SMP before the fw/hw/sw stack
was ready (on H3 IIRC) and I'd rather not relive that experience.
