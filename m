From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 19 May 2015 11:39:23 -0700
Subject: [PATCH v8 1/9] xhci: Set shared HCD's hcd_priv in xhci_gen_setup
In-Reply-To: <1430761002-9327-2-git-send-email-abrestic@chromium.org>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <1430761002-9327-2-git-send-email-abrestic@chromium.org>
Message-ID: <CAL1qeaGo2-T=suBiCTtHmyR1sNeS_ZG-2j2FuuLdGc9vmct2ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathias,

On Mon, May 4, 2015 at 10:36 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> xhci_gen_setup() sets the hcd_priv field for the primary HCD, but not
> for the shared HCD, requiring xHCI host-controller drivers to set it
> between usb_create_shared_hcd() and usb_add_hcd().  There's no reason
> xhci_gen_setup() can't set the shared HCD's hcd_priv as well, so move
> that bit out of the host-controller drivers and into xhci_gen_setup().
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Any chance you could pick this up for 4.2?  It's a dependency for the
xhci-tegra driver which looks like it's going to slip to 4.3 now.

Thanks,
Andrew
