From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Sep 2011 21:14:29 +0200
Subject: [PATCH 3/6] arm/imx6q: add core drivers clock, gpc, mmdc and src
In-Reply-To: <1315303120-24203-4-git-send-email-shawn.guo@linaro.org>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <1711465.COqYbTSZES@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 September 2011 17:58:37 Shawn Guo wrote:
> It adds a number of core drivers support for imx6q, including clock,
> General Power Controller (gpc), Multi Mode DDR Controller(mmdc) and
> System Reset Controller (src).
> 
> Signed-off-by: Ranjani Vaidyanathan <ra5478@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/Kconfig       |   13 +
>  arch/arm/mach-imx/Makefile      |    4 +
>  arch/arm/mach-imx/clock-imx6q.c | 1990 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/gpc.c         |  110 +++
>  arch/arm/mach-imx/mmdc.c        |   71 ++
>  arch/arm/mach-imx/src.c         |   52 +
>  6 files changed, 2240 insertions(+), 0 deletions(-)

This is unfortunately still a major problem. I realize that we don't
yet have a good framework to do this with significantly less code,
but adding a platform that is mostly consisting of stupid additions
of clock descriptions that really should be in the device tree does
not scale much longer. We decided to let this still get in for prima2,
which was also ugly in this regard but much simpler than imx6.

My feeling is that this time, we should wait for the common clock
framework to get in and simplify this. I believe Thomas is now planning
to do this, but I haven't followed what the current state is.

The other three drivers in this patch are basically ok, so you can
definitely post them as a separate patch and perhaps get minor comments
for those, similar to what I commented on the other patches.

For the clock-imx6q.c file, what I first want to hear from someone
is how this is supposed to look like in the long run with device tree
integration, and how far away from that we are.

Can you comment on how far we get without the clock driver with imx6?
Is is basically useless, or is there a way we can merge the remaining
imx6 code and other drivers but postpone the large clock driver?

	Arnd
