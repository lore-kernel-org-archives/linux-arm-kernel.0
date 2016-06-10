From: b-liu@ti.com (Bin Liu)
Date: Fri, 10 Jun 2016 09:53:40 -0500
Subject: [PATCH v3 4/4] musb: sunxi: Simplify dr_mode handling
In-Reply-To: <1465138776-6003-4-git-send-email-hdegoede@redhat.com>
References: <1465138776-6003-1-git-send-email-hdegoede@redhat.com>
 <1465138776-6003-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20160610145340.GE2167@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jun 05, 2016 at 04:59:36PM +0200, Hans de Goede wrote:
> phy-sun4i-usb now has proper dr_mode handling, it always registers an
> extcon, and sends a notify with the mode (even when in peripheral- /
> host-only mode) at least once.
> 
> So we can simply the sunxi musb glue by always registering its extcon
> notifier and relying on sunxi_musb_work() to enable vbus when in
> host-only mode.
> 
> This also enables host- and peripheral-only mode with vbus monitoring.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -No changes
> Changes in v3:
> -No changes

Acked-by: Bin Liu <b-liu@ti.com>

Regards,
-Bin.
