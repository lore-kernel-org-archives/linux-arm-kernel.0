From: sre@ring0.de (Sebastian Reichel)
Date: Tue, 8 Oct 2013 18:04:42 +0200
Subject: [PATCH 0/1] Possibly fix USB OTG on GTA04 and N900
In-Reply-To: <1381152493-28055-1-git-send-email-rogerq@ti.com>
References: <1381152493-28055-1-git-send-email-rogerq@ti.com>
Message-ID: <20131008160442.GA14263@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 07, 2013 at 04:28:12PM +0300, Roger Quadros wrote:
> USB OTG on these boards might be broken on Greg's usb-next branch [1]
> after the Generic PHY framework and associated patches were merged.
> 
> This is a probable fix but I'm not able to test these boards. Please
> give it a try and your Ack if it works. Thanks.
> 
> [1] - git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git

I have tested the Nokia N900 part of the patch. Without this patch
the USB port does not work:

[    1.015014] musb-omap2430 480ab000.usb_otg_hs: unable to find phy

With the patch everything seems to work.

Tested-by: Sebastian Reichel <sre@debian.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131008/05d0843c/attachment.sig>
