From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 Oct 2015 08:05:45 +0200
Subject: [PATCH v4 0/4] simplefb: Add regulator handling support
In-Reply-To: <1445572241-13259-1-git-send-email-wens@csie.org>
References: <1445572241-13259-1-git-send-email-wens@csie.org>
Message-ID: <20151023060545.GE10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 11:50:37AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v4 of the simplefb regulator support series. This series adds
> regulator claiming and enabling support for simplefb.
> 
> Changes since v4:
>   - Fixed inverted logic when testing the property name.
>   - Fixed regulator supply name string copy length off by 1.
>   - Added real world user, MSI Primo 81 dts patches.
> 
> Changes since v3:
>   - Dropped extra "if" which is always true, leftover from v1.
>   - Updated commit message of patch 1
> 
> Sometimes the simplefb display output path consits of external conversion
> chips and/or LCD drivers and backlights. These devices normally have
> GPIOs to turn them on and/or bring them out of reset, and regulators
> supplying power to them.
> 
> While the kernel does not touch unclaimed GPIOs, the regulator core
> happily disables unused regulators. Thus we need simplefb to claim
> and enable the regulators used throughout the display pipeline.
> 
> The binding supports any named regulator supplies under its device
> node. The driver will look through its properties, and claim any
> regulators by matching "*-supply", as Mark suggested.
> 
> I've not done a generic helper in the regulator core yet, instead doing
> the regulator property handling in the simplefb code for now.
> 
> 
> Patch 1 adds the regulator properties to the DT binding.
> 
> Patch 2 adds code to the simplefb driver to claim and enable regulators.
> Hans, I dropped your Reviewed-by tag from this patch.
> 
> Patch 3 adds labels to the simplefb device nodes in sun6i-a31.dtsi
> so we can reference them in the board dts files, like in the next
> patch.
> 
> Patch 4 adds a dts file for MSI's Primo 81 tablet.

Applied 3 and 4.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151023/0197e5a3/attachment.sig>
