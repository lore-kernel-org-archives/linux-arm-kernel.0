From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Apr 2016 11:05:51 +0800
Subject: [PATCH 1/3] ARM: dts: imx6q-b850v3: Remove ldb panel
In-Reply-To: <1461014385-26027-1-git-send-email-akshay.bhat@timesys.com>
References: <1461014385-26027-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <20160426030551.GD8870@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 05:19:43PM -0400, Akshay Bhat wrote:
> Remove ldb panel entry for the following reasons:
> - The b850v3 has an onboard LVDS to DisplayPort converter (STDP4028). So
> we should not limit the monitors that can be connected by hardcoding the
> auo,b133htn01 1080p panel.
> - The default resolution on the LVDS interface needs to be WXGA or less.
> Otherwise when a 1080p monitor is connected to the HDMI port there is no
> output on both the LVDS and HDMI ports since a single IPU on i.MX6 can
> not handle two 1080p displays. With the panel entry removed from the
> devicetree, drm driver defaults the resolution on LVDS interface to XGA.
> 
> Once in userspace, applications can set the desired resolution on LVDS
> interface over IPU2 CRTC.
> 
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>

Applied all, thanks.
