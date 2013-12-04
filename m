From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 4 Dec 2013 12:00:34 +0200
Subject: [PATCH v2 0/3] ARM: OMAP2+: USB Host bug fixes for 3.13 rc
In-Reply-To: <1386080748-17005-1-git-send-email-rogerq@ti.com>
References: <1386080748-17005-1-git-send-email-rogerq@ti.com>
Message-ID: <529EFD42.9070507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-03 16:25, Roger Quadros wrote:
> Hi,
> 
> This is a follow up solution to the original series in [1]
> 
> The first patch fixes the OMAP4 Panda USB detection problems on 3.13-rc1
> with u-boot v2013.10.
> 
> The remaining 2 patches are required if SOFTRESET needs to be done for the
> USB Host module on OMAP3 platforms.
> 
> Patch 2 fixes the hwmod RESET logic to prevent multiple SOFTRESETs
> being issued to the modules. This multiple SOFTRESET was causing problems
> with OMAP3 USB Host module. On Beagleboard C4 this is seen as failure to
> mount NFS root over external USB to Ethernet device.
> 
> This might be the reason why HWMOD_INIT_NO_RESET was used for the OMAP
> USB host module in OMAP3 hwmod data and just carried forward in OMAP4
> and OMAP5 hwmod data as well.
> 
> cheers,
> -roger

Tested on Panda and Beagle xM. Works fine for me.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/073597ac/attachment.sig>
