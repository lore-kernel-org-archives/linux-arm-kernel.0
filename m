From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 05 Apr 2013 10:56:03 -0700
Subject: [PATCH 0/5] gpio/omap: 2nd batch of updates for v3.10
In-Reply-To: <1365106576-31816-1-git-send-email-jon-hunter@ti.com> (Jon
 Hunter's message of "Thu, 4 Apr 2013 15:16:11 -0500")
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Message-ID: <87hajklv4c.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon Hunter <jon-hunter@ti.com> writes:

> Main change is ensuring that the state of a gpio bank is restored when
> booting with device-tree. The rest of the patches are clean-ups and one
> optimisation.
>
> The patch modifying the *.dtsi files should go via Benoit Cousson's
> for_3.10/dts branch [1] as it is dependent on changes in his branch but
> I have included here for completeness.
>
> Testing includes:
> - Boot testing on OMAP5912 OSK, OMAP2420 H4, OMAP3430 SDP, OMAP4430 SDP
>   and AM335x EVM.
> - Verified that GPIO interrupts are working on OMAP5912 OSK, OMAP2420 H4,
>   OMAP3430 SDP and OMAP4430 SDP by making sure networking was working
>   correctly as these boards use a GPIO with the ethernet chips. Also
>   checked /proc/interrupts to ensure GPIO interrupt counts are
>   incrementing as expected.
>
> [1] http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git
>
> Jon Hunter (4):
>   gpio/omap: free irq domain in probe() failure paths
>   gpio/omap: optimise interrupt service routine
>   gpio/omap: force restore if context loss is not detectable
>   ARM: dts: OMAP2+: Identify GPIO banks that are always powered
>
> Tarun Kanti DebBarma (1):
>   gpio/omap: remove extra context restores in *_runtime_resume()

For the gpio/omap patches

Reviewed-by: Kevin Hilman <khilman@linaro.org>
