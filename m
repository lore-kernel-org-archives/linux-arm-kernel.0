From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Apr 2014 21:42:49 +0100
Subject: [PATCH v2] staging: imx-drm-core: skip components whose parent
 device is disabled
In-Reply-To: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
References: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140418204249.GG24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 10:02:26AM +0800, Shawn Guo wrote:
> In a board setup which disables LDB device node completely by changing
> status to 'disabled', and only enables HDMI device, we're running into
> the problem that imx-drm master never succeeds in binding, and hence
> HDMI does not come up either.
> 
> &ldb {
> 	status = "disabled";
> 
> 	lvds-channel at 1 {
> 		...
> 		status = "okay";
> 	};
> };
> 
> The imx-drm-core should really skip the LVDS channels no matter what
> lvds-channel's status is, if LDB device is disabled.  Let's consider
> such setup a misconfiguration, give a warning in there and not add the
> component.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes since v1:
> * Put a warning on such misconfiguration

Thanks Shawn, I've added it to my queue for Greg.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
