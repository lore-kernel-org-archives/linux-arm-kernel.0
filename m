From: sre@ring0.de (Sebastian Reichel)
Date: Mon, 20 Jan 2014 19:00:54 +0100
Subject: [PATCHv13 27/40] ARM: dts: omap3 clock data
In-Reply-To: <1389276051-1326-28-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <1389276051-1326-28-git-send-email-t-kristo@ti.com>
Message-ID: <20140120180053.GA25920@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I just found some time to update my SSI driver adding DT clock
support. It works, but I wonder if the alias of the ssi clocks
can be changed to something like the following:

/* omap3430es1-clocks.dtsi */
ssi_ick: ssi_ick_3430es1 {};
ssi_ssr_fck: ssi_ssr_fck_3430es1 {};
ssi_sst_fck: ssi_sst_fck_3430es1 {};

/* omap36xx-omap3430es2plus-clocks.dtsi */
ssi_ick: ssi_ick_3430es2 {};
ssi_ssr_fck: ssi_ssr_fck_3430es2 {};
ssi_sst_fck: ssi_sst_fck_3430es2 {};

With this change I can reference the ssi clocks in omap3.dtsi
instead of creating files for omap3430es1 and omap3430es2+.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140120/d029b721/attachment.sig>
