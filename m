From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 May 2015 10:38:16 -0500
Subject: [PATCH 1/3] phy-sun4i-usb: Add a sunxi specific function for
 setting squelch-detect
In-Reply-To: <1427626248-6257-2-git-send-email-hdegoede@redhat.com>
References: <1427626248-6257-1-git-send-email-hdegoede@redhat.com>
 <1427626248-6257-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150526153816.GK26599@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 29, 2015 at 12:50:46PM +0200, Hans de Goede wrote:
> The sunxi otg phy has a bug where it wrongly detects a high speed squelch
> when reset on the root port gets de-asserted with a lo-speed device.
> 
> The workaround for this is to disable squelch detect before de-asserting
> reset, and re-enabling it after the reset de-assert is done. Add a sunxi
> specific phy function to allow the sunxi-musb glue to do this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Kishon, do you want to take this patch?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/757cfc83/attachment.sig>
