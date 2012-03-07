From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 7 Mar 2012 07:38:29 +0100
Subject: [PATCH/RFC 2/2] arm/tegra: add timeout to PCIe PLL lock
 detection loop
In-Reply-To: <1331023544-6439-3-git-send-email-mad_soft@inbox.ru>
References: <1331023544-6439-1-git-send-email-mad_soft@inbox.ru>
 <1331023544-6439-3-git-send-email-mad_soft@inbox.ru>
Message-ID: <20120307063829.GA16359@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dmitry Artamonow wrote:
[...]
> diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
[...]
> @@ -639,8 +639,14 @@ static void tegra_pcie_enable_controller(void)
>  	pads_writel(0xfa5cfa5c, 0xc8);
>  
>  	/* Wait for the PLL to lock */
> +	timeout = 2000;

FWIW, the Vibrante kernel uses 300 for the timeout value.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120307/0a7f99d6/attachment-0001.sig>
