From: b-liu@ti.com (Bin Liu)
Date: Fri, 3 Jun 2016 08:12:13 -0500
Subject: [PATCH 1/4] USB: Fix of_usb_get_dr_mode_by_phy with a shared phy
 block
In-Reply-To: <e8b770aa-5642-93c3-60c8-0717e87e732e@redhat.com>
References: <1464888666-17728-1-git-send-email-hdegoede@redhat.com>
 <575167EC.8000504@ti.com>
 <e8b770aa-5642-93c3-60c8-0717e87e732e@redhat.com>
Message-ID: <20160603131213.GB3778@uda0271908>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 03, 2016 at 01:39:26PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 03-06-16 13:20, Kishon Vijay Abraham I wrote:
> >Hi,
> >
> >On Thursday 02 June 2016 11:01 PM, Hans de Goede wrote:
> >>Some SoCs have a single phy-hw-block with multiple phys, this is
> >>modelled by a single phy dts node, so we end up with multiple
> >>controller nodes with a phys property pointing to the phy-node
> >>of the otg-phy.
> >
> >Maybe we should try to model each phy with a separate dt node?
> 
> That seems like making things unnecessarily complicated. If we want
> to be 100% sure that of_usb_get_dr_mode_by_phy finds the right

I believe we have to.

> controller, we could add an "int index" parameter to of_usb_get_dr_mode_by_phy
> and make it check that first argument specified to the phandle
> used in the controller node matches the passed in index.

Why we need the 'index'? Once the dt has seperate nodes for the phys,
'phy_np' passed in is the uniqe id of the phy node.

> 
> And use index == -1 to skip this test.
> 
> Regards,
> 
> Hans

Regards,
-Bin.
