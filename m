From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 3 Mar 2016 20:35:59 -0800
Subject: [PATCH v4 1/2] ehci-platform: Add support for controllers with
 multiple reset lines
In-Reply-To: <1456592339-31767-2-git-send-email-hdegoede@redhat.com>
References: <1456592339-31767-1-git-send-email-hdegoede@redhat.com>
 <1456592339-31767-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160304043559.GA21743@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 27, 2016 at 05:58:58PM +0100, Hans de Goede wrote:
> From: Reinder de Haan <patchesrdh@mveas.com>
> 
> At least the EHCI/OHCI found on the Allwinnner H3 SoC needs multiple
> reset lines, the controller will not initialize while the reset for
> its companion is still asserted, which means we need to de-assert
> 2 resets for the controller to work.
> 
> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v2:
> -Use the new reset_control_[de]assert_shared reset-controller functions
> Changes in v3:
> -Adjust for changes to shared-reset reset-controller functions
> Changes in v4:
> -Fix Ugly continuation line

This breaks the build horribly :(

As does patch 2/2, ugh.
