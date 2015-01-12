From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 14:42:03 -0800
Subject: [PATCH V2] ARM: dts: Only build dtb if associated Arch and/or
 SoC is enabled
In-Reply-To: <1419920427-29121-1-git-send-email-pbrobinson@gmail.com>
References: <1419920427-29121-1-git-send-email-pbrobinson@gmail.com>
Message-ID: <20150112224203.GL22090@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 30, 2014 at 06:20:27AM +0000, Peter Robinson wrote:
> A number of arches (EXYNOS/IMX/TEGRA) are separated out into finer grained
> definitions whether it be sub ARCH or SOC definitions. The device tree blobs
> should only be built if the specific option is enabled that supports that
> device or it might be that there's an expectation that the device is supported
> when in actual fact it's not. This ensures only the relevant bits are built.
> 
> Also standardised the line break between the arch/soc definitions and the
> dtbs to be on separate lines for better consistency as per feedback.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Acked-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/boot/dts/Makefile | 213 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 141 insertions(+), 72 deletions(-)

(adding Nicolas on cc)

Nice cleanup, but I really wish we had split up into subdirectories on ARM
much earlier. Doing that now is too much churn.

AT91 now sticks out a bit with its special case in formatting. Could be
worth changing at some point.

I've applied this on next/dt now, hopefully it won't become too much of
a headache of conflicts during this release cycle. At least doing it on that
branch should keep us from exposing it up outside our tree.



-Olof
