From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 19 Jan 2016 10:52:54 +0800
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <Pine.LNX.4.44L0.1601181129340.25155-100000@netrider.rowland.org>
References: <20160118071309.GC8150@shlinux2>
 <Pine.LNX.4.44L0.1601181129340.25155-100000@netrider.rowland.org>
Message-ID: <20160119025254.GA24548@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 11:39:06AM -0500, Alan Stern wrote:
> On Mon, 18 Jan 2016, Peter Chen wrote:
> 
> > > > Why can't the root_hub reuse dev->dev.of_node?
> > > 
> > > Indeed, there's no need to add an .of_node field to struct usb_device, 
> > > since the embedded struct device already contains an .of_node field.
> > > 
> > 
> > No, the usb_device needs the .of_node field.
> 
> It already _has_ an .of_node field, in its embedded struct device.
> 
> > The devices belong to platform bus contains device node.
> > The devices (usb device) belong to USB bus which are created
> > dynamically do not contain device node.
> 
> I don't know what you mean.  struct usb_device _does_ contain an 
> embedded struct device.  It doesn't matter the structures are created 
> dynamically, statically, or any other way; this field is part of the 
> structure definition.
> 
> Suppose udev is a pointer to struct usb_device.  Then udev->dev is a
> struct device and udev->dev.of_node is a pointer to struct device_node.  
> You don't need to add a new udev->of_node field; just use
> udev->dev.of_node instead.
> 

Yes, you are right.

-- 

Best Regards,
Peter Chen
