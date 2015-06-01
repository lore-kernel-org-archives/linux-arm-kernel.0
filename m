From: linux-arm@myspectrum.nl (Jeroen Hofstee)
Date: Mon, 01 Jun 2015 18:56:53 +0200
Subject: [PATCH] ARM: dts: AM35xx: fix system control module clocks
In-Reply-To: <1433172627-28052-1-git-send-email-t-kristo@ti.com>
References: <alpine.DEB.2.02.1506010546510.14902@utopia.booyaka.com>
 <1433172627-28052-1-git-send-email-t-kristo@ti.com>
Message-ID: <556C8ED5.5050000@myspectrum.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tero,

On 01-06-15 17:30, Tero Kristo wrote:
> New system control module layout for omap3 overlooked parts of the am35xx
> configuration. Basically the am35xx clocks were not converted to use the
> changed offsets, which caused weird boot warnings. The errors were not
> fatal so far, so they were not caught earlier. Fixed by applying the
> proper offsets for the AM35xx scm clocks.
>
> Fixes: b8845074cf ("ARM: dts: omap3: add minimal l4 bus layout with...")
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reported-by: Jeroen Hofstee <linux-arm@myspectrum.nl>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>   arch/arm/boot/dts/am35xx-clocks.dtsi |   14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
With this patch the error interrupt / stack dumps are no longer present.

Thanks,

Tested-by: Jeroen Hofstee <jeroen@myspectrum.nl>
