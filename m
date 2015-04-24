From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 24 Apr 2015 11:05:37 -0600
Subject: [PATCH] ARM: tegra: Add missing HDMI +5V regulator
In-Reply-To: <1429869954-5909-1-git-send-email-thierry.reding@gmail.com>
References: <1429869954-5909-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <553A77E1.8030402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2015 04:05 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Commit fb50a116bbbc ("drm/tegra: hdmi - Add connector supply support")
> introduced a new supply for HDMI connectors that is used to control the
> voltage on the +5V pin. Not all boards have had the corresponding supply
> added to their device tree files, causing the following warning message
> during boot:
>
> 	[    0.859698] 54280000.hdmi supply hdmi not found, using dummy regulator
>
> Add such a regulator to the Seaboard DTS to enable the driver to control
> this voltage and get rid of the warning.
>
> Reported-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Hi Stephen,
>
> This is completely untested because I don't have a Seaboard. But this is
> based on the schematics and I think it should work, so it'd be great if
> you could test it.

Tested-by: Stephen Warren <swarren@nvidia.com> (on top of v4.0).
