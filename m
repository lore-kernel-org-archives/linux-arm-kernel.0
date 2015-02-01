From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Sun, 1 Feb 2015 02:51:22 +0100
Subject: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
In-Reply-To: <20150117164709.GS18552@atomide.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com>
 <20150117164709.GS18552@atomide.com>
Message-ID: <CAALWOA-XVrC84=6Xt04m+QaBhweAcp2HVTH7v=QewtJmQLEaWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I just noticed the dm816x.dtsi says:

ocp {
        compatible = "ti,omap3-l3-smx", "simple-bus";

This is incorrect: the DM81xx (and siblings like the AM335x) use
Arteris FlexNOC for the L3 interconnect, same as omap4/5 and vayu, not
SonicsMX. (In general everything on the DM81xx seems to be
omap4-generation)
