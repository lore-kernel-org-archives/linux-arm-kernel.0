From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Jun 2016 08:25:18 -0500
Subject: [PATCH v5 resend 1/2] ehci-platform: Add support for controllers
 with multiple reset lines
In-Reply-To: <1464880446-5919-2-git-send-email-hdegoede@redhat.com>
References: <1464880446-5919-1-git-send-email-hdegoede@redhat.com>
 <1464880446-5919-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160606132518.GA15153@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 05:14:05PM +0200, Hans de Goede wrote:
> From: Reinder de Haan <patchesrdh@mveas.com>
> 
> At least the EHCI/OHCI found on the Allwinnner H3 SoC needs multiple
> reset lines, the controller will not initialize while the reset for
> its companion is still asserted, which means we need to de-assert
> 2 resets for the controller to work.
> 
> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use the new reset_control_[de]assert_shared reset-controller functions
> ---
>  Documentation/devicetree/bindings/usb/usb-ehci.txt |  2 +-

I acked v4. Please add acks when posting new versions.

Rob

>  drivers/usb/host/ehci-platform.c                   | 41 ++++++++++++----------
>  2 files changed, 24 insertions(+), 19 deletions(-)
