From: b-liu@ti.com (Bin Liu)
Date: Fri, 3 Jun 2016 08:04:54 -0500
Subject: [PATCH 1/4] USB: Fix of_usb_get_dr_mode_by_phy with a shared phy
 block
In-Reply-To: <88cada17-af4c-9548-e734-351b6695e30f@redhat.com>
References: <1464888666-17728-1-git-send-email-hdegoede@redhat.com>
 <20160602181648.GB28820@uda0271908>
 <88cada17-af4c-9548-e734-351b6695e30f@redhat.com>
Message-ID: <20160603130454.GA3778@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 03, 2016 at 12:34:35PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 02-06-16 20:16, Bin Liu wrote:
> >Hi,
> >
> >On Thu, Jun 02, 2016 at 07:31:03PM +0200, Hans de Goede wrote:
> >>Some SoCs have a single phy-hw-block with multiple phys, this is
> >>modelled by a single phy dts node, so we end up with multiple
> >>controller nodes with a phys property pointing to the phy-node
> >>of the otg-phy.
> >>
> >>Only one of these controllers typically is an otg controller, yet we
> >
> >Is it guaranteed that only one of them will be otg?
> 
> I guess not, but if there are 2 then with my patch we are of no worse
> then today, we will then pick the first otg controller. Whereas

What if the first otg controller is not what we want? this patch does
not solve the problem. I would think Kishon's suggestion in another
email - seperate dt phy nodes - is a better option.

> of_usb_get_dr_mode_by_phy currently is broken even on setups with
> a shared phy dt-node and only 1 otg controller, which are quite
> common.

If that is the case, the model has to be changed. Otherwise, a single
phy driver is unable to handle different operations from multiple
controllers.

Regards,
-Bin.
