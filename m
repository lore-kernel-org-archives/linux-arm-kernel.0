From: mathias.nyman@linux.intel.com (Mathias Nyman)
Date: Fri, 22 May 2015 15:19:19 +0300
Subject: [PATCH v8 1/9] xhci: Set shared HCD's hcd_priv in xhci_gen_setup
In-Reply-To: <CAL1qeaGo2-T=suBiCTtHmyR1sNeS_ZG-2j2FuuLdGc9vmct2ug@mail.gmail.com>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>	<1430761002-9327-2-git-send-email-abrestic@chromium.org>
 <CAL1qeaGo2-T=suBiCTtHmyR1sNeS_ZG-2j2FuuLdGc9vmct2ug@mail.gmail.com>
Message-ID: <555F1EC7.602@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 19.05.2015 21:39, Andrew Bresticker wrote:
> Hi Mathias,
> 
> On Mon, May 4, 2015 at 10:36 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>> xhci_gen_setup() sets the hcd_priv field for the primary HCD, but not
>> for the shared HCD, requiring xHCI host-controller drivers to set it
>> between usb_create_shared_hcd() and usb_add_hcd().  There's no reason
>> xhci_gen_setup() can't set the shared HCD's hcd_priv as well, so move
>> that bit out of the host-controller drivers and into xhci_gen_setup().
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Reviewed-by: Felipe Balbi <balbi@ti.com>
>> Cc: Mathias Nyman <mathias.nyman@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Any chance you could pick this up for 4.2?  It's a dependency for the
> xhci-tegra driver which looks like it's going to slip to 4.3 now.
> 

I got some internal tasks I need(ed) to attend, and I'm a bit late with
the 4.2 patches. I'll try to sort it out next week. 

A got some patches from Roger Quadros where he changed 
how struct xhci_hcd is allocated to get xhci working with OTG code.

That code will conflict with patch 1/9, so patch 1/9 will probably be dropped,
but that shouldn't affect the rest of your patches.

-Mathias
