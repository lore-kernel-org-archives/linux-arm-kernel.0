From: david@lechnology.com (David Lechner)
Date: Mon, 10 Oct 2016 18:27:49 -0500
Subject: [PATCH/RFT 08/12] ARM: davinci: register the usb20_phy clock on
 the SoC file
In-Reply-To: <1475858577-10366-9-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
 <1475858577-10366-9-git-send-email-ahaslam@baylibre.com>
Message-ID: <383dd208-ff45-fde9-6500-ca12ec0ca805@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2016 11:42 AM, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
>
> The usb20_phy clock needs to be registered for the driver to be able
> to get and enable a clock. Currently the usb phy clocks are registered
> form board files, which will not be called during a device tree based
> boot.
>
> To be able to probe correctly usb form a device tree boot, register
> the usb phy clocks form the SoC specific init.
>
> Unfourtunatly, davinci does not have proper clock support on device tree
> yet, so by registering the clock form de SoC specific file we are
> forced to hardcode the parent clock, and cannot select refclkin as
> parent for any of the phy clocks of the da850 family.

FYI, I have started working on the clocks as well if you want to take it 
and run with it.

https://github.com/dlech/ev3dev-kernel/compare/9d6b50cde34b51309c74d97c26b1430c7ff6aa0f...d02084598785c369fdb23884171cbbec4fef77b0

(Ignore the ev3dev commit stuck in the middle there.)

>
> As none of the current da850 based boards currently in mainline use
> refclkin as source. I guess we can live with this limitation until clocks
> are correctly represented through CCF/device tree.
>
