From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 25 Jan 2016 15:04:31 +0100
Subject: [PATCH v3 7/8] clk: rockchip: fix usbphy-related clocks
In-Reply-To: <1447968149-10979-8-git-send-email-heiko@sntech.de>
References: <1447968149-10979-1-git-send-email-heiko@sntech.de>
 <1447968149-10979-8-git-send-email-heiko@sntech.de>
Message-ID: <4016576.NEsgSPjyJ9@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kishon,

Am Donnerstag, 19. November 2015, 22:22:28 schrieb Heiko Stuebner:
> The otgphy clocks really only drive the phy blocks. These in turn
> contain plls that then generate the 480m clocks the clock controller
> uses to supply some other clocks like uart0, gpu or the video-codec.
> 
> So fix this structure to actually respect that hirarchy and removed
> that usb480m fixed-rate clock working as a placeholder till now, as
> this wouldn't even work if the supplying phy gets turned off while
> its pll-output gets used elsewhere.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

it looks like this patch didn't make your cutoff time for sending your stuff 
to Greg. As the core phy series up to patch 5 is in mainline now, I've just 
applied this patch to my clk-branch for 4.6.


Heiko
