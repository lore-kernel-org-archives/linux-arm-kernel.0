From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 19 Dec 2015 18:21:42 +0100
Subject: [PATCH v3 7/8] clk: rockchip: fix usbphy-related clocks
In-Reply-To: <566FF0F0.6080803@ti.com>
References: <1447968149-10979-1-git-send-email-heiko@sntech.de>
 <1447968149-10979-8-git-send-email-heiko@sntech.de> <566FF0F0.6080803@ti.com>
Message-ID: <80597401.Y78Rj8FshV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Am Dienstag, 15. Dezember 2015, 16:22:32 schrieb Kishon Vijay Abraham I:
> On Friday 20 November 2015 02:52 AM, Heiko Stuebner wrote:
> > The otgphy clocks really only drive the phy blocks. These in turn
> > contain plls that then generate the 480m clocks the clock controller
> > uses to supply some other clocks like uart0, gpu or the video-codec.
> > 
> > So fix this structure to actually respect that hirarchy and removed
> > that usb480m fixed-rate clock working as a placeholder till now, as
> > this wouldn't even work if the supplying phy gets turned off while
> > its pll-output gets used elsewhere.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> I saw you've given your Acked-by in a previous version of this patch.
> Do you want me to take this in linux-phy tree?

from my POV, this series should probably go through your tree in one go, as 
this patch depends on the newly exposed clocks from the previous patch. So to 
keep bisectability, it should most likely stay together.


Heiko
