From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Jan 2015 14:50:02 +0100
Subject: [PATCH] ARM: dts: Fix missing usb0_reset for sun4i / sun5i
In-Reply-To: <1419448758-22371-2-git-send-email-hdegoede@redhat.com>
References: <1419448758-22371-1-git-send-email-hdegoede@redhat.com>
 <1419448758-22371-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150105135002.GB32429@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wed, Dec 24, 2014 at 08:19:18PM +0100, Hans de Goede wrote:
> The recent sun4i-usb-phy changes to add (preliminary) support for the oth phy,
> cause the ehci/ohci controllers to no longer work on sun4i / sun5i, because
> the phy driver refuses to load due to a missing usb0_reset reset controller
> in the dts files for sun4i / sun5i:
> 
> [    0.094293] sun4i-usb-phy 1c13400.phy: failed to get reset usb0_reset
> [    0.094326] sun4i-usb-phy: probe of 1c13400.phy failed with error -22
> 
> This fixes this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks for this. Chen-Yu submitted a similar patch before the holidays
that I queued for 3.19, but didn't push at the time.

It's now pushed as part as sunxi/fixes-for-3.19, and sunxi/for-next.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/6207df47/attachment.sig>
