From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Nov 2014 21:40:00 +0100
Subject: [PATCH v2 1/9] clk: sunxi: Give sunxi_factors_register a
 registers parameter
In-Reply-To: <1416749895-25013-2-git-send-email-hdegoede@redhat.com>
References: <1416749895-25013-1-git-send-email-hdegoede@redhat.com>
 <1416749895-25013-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20141126204000.GM25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 23, 2014 at 02:38:07PM +0100, Hans de Goede wrote:
> Before this commit sunxi_factors_register uses of_iomap(node, 0) to get
> the clk registers. The sun6i prcm has factor clocks, for which we want to
> use sunxi_factors_register, but of_iomap(node, 0) does not work for the prcm
> factor clocks, because the prcm uses the mfd framework, so the registers
> are not part of the dt-node, instead they are added to the platform_device,
> as platform_device resources.
> 
> This commit makes getting the registers the callers duty, so that
> sunxi_factors_register can be used with mfd instantiated platform device too.
> 
> While at it also add error checking to the of_iomap calls.
> 
> This commit also drops the __init function from sunxi_factors_register since
> platform driver probe functions are not __init.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Queued for 3.20, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/e3e5ffcc/attachment.sig>
