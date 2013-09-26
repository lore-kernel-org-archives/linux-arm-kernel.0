From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Sep 2013 17:21:21 -0600
Subject: [PATCH 1/2] dts: socfpga: Add ethernet support on Altera's SOCFPGA
 platform
In-Reply-To: <1380057120-27108-1-git-send-email-dinguyen@altera.com>
References: <1380057120-27108-1-git-send-email-dinguyen@altera.com>
Message-ID: <5244C171.2040705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 03:11 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The STMMAC Ethernet controller in SOCFPGA requires setting a register for
> the phy-mode that is outside of the ethernet IP. This register resides in
> the System Manager block. So we define a new DTS binding
> "altr,sysmgr-phy-mask". This binding's property is a bitmask that can be
> used to set the correct register bit.

> diff --git a/Documentation/devicetree/bindings/net/stmmac-altr-socfpga.txt b/Documentation/devicetree/bindings/net/stmmac-altr-socfpga.txt

> +* altr,sysmgr-phy-mask: This property contains the bitmask that is needed to
> +	set the appropriate register bits for the phy-mode in the System Manager.
> +	The value should be:
> +		-Ethernet Controller 1 (gmac0) = 0x3
> +		-Ethernet Controller 2 (gmac1) = 0xC

Wouldn't you need a phandle to the sysmgr node so that the driver could
be located, and a register number within its register block too? Or,
does sysmgr know which register to poke? If so, couldn't the API take
just a device index rather than a bitmask instead, and calculate the
mask itself?
