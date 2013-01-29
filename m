From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Jan 2013 10:11:31 -0700
Subject: [PATCH, RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <510802C3.7090803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 04:22 AM, Sascha Hauer wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> This adds two little devicetree helper functions for determining the
> dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> the devicetree.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> 
> The properties and their values have been taken from the fsl-mph-dr driver.
> This binding is also documented (though currently not used) for the tegra
> ehci driver (Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt).
> This is a first attempt to parse these bindings at a common place so that
> others can make use of it.
> 
> Basically I want to know whether this binding is recommended for new drivers
> since normally the devicetree uses '-' instead of '_', and maybe there are
> other problems with it.

It's certainly typical to use - not _ for freshly defined properties.
However, since this property already exists and is in-use, I don't think
there's any choice but to maintain its current definition.

The code looked fine to me.
