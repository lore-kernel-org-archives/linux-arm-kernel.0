From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 Nov 2016 15:28:39 +0530
Subject: [PATCH v8 3/3] ARM: davinci: da8xx: register USB PHY clocks in
 the DT file
In-Reply-To: <1477946841-16126-4-git-send-email-david@lechnology.com>
References: <1477946841-16126-1-git-send-email-david@lechnology.com>
 <1477946841-16126-4-git-send-email-david@lechnology.com>
Message-ID: <dab6f964-21f1-a0c4-643e-6d43568af63a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 November 2016 02:17 AM, David Lechner wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> The usb20_phy clock needs to be registered for the driver to be able
> to get and enable a clock. Currently the usb phy clocks are registered
> form board files, which will not be called during a device tree based
> boot.
> 
> To be able to probe correctly usb form a device tree boot, register
> the usb phy clocks form the DT specific init.
> 
> Unfourtunatly, davinci does not have proper clock support on device tree
> yet, so by registering the clock form de DT specific file we are
> forced to hardcode the parent clock, and cannot select refclkin as
> parent for any of the phy clocks of the da850 family.
> 
> As none of the current da850 based boards currently in mainline use
> refclkin as source. I guess we can live with this limitation until clocks
> are correctly represented through CCF/device tree.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> [Added error checking]
> Signed-off-by: David Lechner <david@lechnology.com>

Applied to v4.10/soc with some typo fixes.

s/form/from
s/Unfourtunatly/Unfortunately
s/de/the

Thanks,
Sekhar
