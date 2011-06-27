From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Jun 2011 18:05:44 +0300
Subject: [PATCHv2] OMAP4: PANDA, SDP: Fix EHCI regulator supply
In-Reply-To: <1309186923-29192-1-git-send-email-jaswinder.singh@linaro.org>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
	<1309186923-29192-1-git-send-email-jaswinder.singh@linaro.org>
Message-ID: <20110627150543.GR2508@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 08:32:03PM +0530, Jassi Brar wrote:
> VUSB is a fixed level line and hence have no set_voltage
> callback in regulator ops, but has apply_uV set to true.
> As a result it fails to register with the regulator core.
> Remove setting apply_uV.
> 
> Also, assign name to VUSB supply, without which regulator core
> fails to find it and assigns the default 'dummy' regulator to
> the ehci-omap device.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110627/fda49ccc/attachment.sig>
