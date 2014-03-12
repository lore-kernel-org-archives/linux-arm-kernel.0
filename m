From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 12 Mar 2014 12:33:04 +0200
Subject: [PATCH] ARM: OMAP5: DSS hwmod data
In-Reply-To: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <532037E0.1080309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/14 12:26, Tomi Valkeinen wrote:
> Hi,
> 
> This patch adds hwmod data for omap5 display subsystem. I have tested this on
> omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output yet, as the
> mainline is missing omap5 HDMI driver.
> 
> I do see this when booting:
> 
>   omap_hwmod: dss_dispc: cannot be enabled for reset (3)
>   omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
>   omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
>   omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
>   omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
> 
> But at least DSI works just fine.

Oh, I forgot to say that I tested this on top of the DSS DT branch, and
unpublished omap5 and omap5-uevm display patches. So if applied to the
current mainline, the hwmods are not used at all (except the reset at
boot time, I think).

But if this gets merged for 3.15, it'll make adding omap5 DSS support
easier for 3.16 as the HWMOD data is already there.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/73433334/attachment.sig>
