From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 11 Feb 2014 11:43:00 -0500 (EST)
Subject: [PATCH v2 1/2] ohci-platform: Change compatible string from
 usb-ohci to generic-ohci
In-Reply-To: <1392136529-5060-2-git-send-email-hdegoede@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1402111142260.1209-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Feb 2014, Hans de Goede wrote:

> The initial versions of the devicetree enablement patches for ohci-platform
> used "ohci-platform" as compatible string. However this was disliked by various
> reviewers because the platform bus is a Linux invention and devicetree is
> supposed to be OS agnostic. After much discussion I gave up and went with
> the generic usb-ohci as requested.
> 
> In retro-spect I should have chosen something different, the dts files for many
> existing boards already claim to be compatible with "usb-ohci", ie they have:
> 
> 	compatible = "ti,ohci-omap3", "usb-ohci";
> 
> In theory this should not be a problem since the "ti,ohci-omap3" entry takes
> presedence, but in practice using a conflicting compatible string is an issue,
> because it makes which driver gets used depend on driver registration order.
> 
> This patch changes the compatible string claimed by ohci-platform to
> "generic-ohci", avoiding the driver registration / module loading ordering
> problems.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

For both v2 patches:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
