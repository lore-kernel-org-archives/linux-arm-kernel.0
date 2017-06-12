From: horms@verge.net.au (Simon Horman)
Date: Mon, 12 Jun 2017 11:06:56 +0200
Subject: [PATCH v2] ARM: dts: r8a779x: Fix PCI bus dtc warnings
In-Reply-To: <1497023440-23845-1-git-send-email-geert+renesas@glider.be>
References: <1497023440-23845-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170612090655.GB15434@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 05:50:40PM +0200, Geert Uytterhoeven wrote:
> From: Rob Herring <robh@kernel.org>
> 
> The bogus 'device_type = "pci"' confuses dtc, causing lots of totally
> unrelated warnings.  After fixing that, real warnings like
> 
>     arch/arm/boot/dts/r8a7790-lager.dtb: Warning (pci_device_reg): Node /pci at ee090000/usb at 0,1 PCI unit address format error, expected "1,0"
> 
> are left.  Correct the unit-addresses and reg properties of the subnodes
> to fix these.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> [geert: Improve description]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.13.
