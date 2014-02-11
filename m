From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Feb 2014 16:54:28 +0100
Subject: ohci-/ehci-platform: Change compatible string to ?hci-platform
In-Reply-To: <1635726.gc3dEs0zOi@wuerfel>
References: <Pine.LNX.4.44L0.1402111023240.1209-100000@iolanthe.rowland.org>
 <1635726.gc3dEs0zOi@wuerfel>
Message-ID: <52FA47B4.50507@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/11/2014 04:43 PM, Arnd Bergmann wrote:
> On Tuesday 11 February 2014 10:27:12 Alan Stern wrote:
>>
>> It might even be a good idea to change the "xhci-platform" string to 
>> match, it that doesn't cause too much trouble.
> 
> The original xhci binding was contributed by Al Cooper, but I don't
> see any dts files using it. I agree that xhci-generic is a better
> name than xhci-platform, and I think we should make that the recommended
> string. If Al or someone thinks the xhci-generic string might already
> be used in production devices, we should however allow both names
> in the binding and in the driver.

I can live with generic as pre/post fix. Looking at what seems to
be the common trend I believe it should be a pre-fix and nost a post-fix
though.

The common way to build a compatible string seems to be:
vendor,soc_model-function. We have a few deviations from this in the
usb bindings, but ie the interrupt-controller bindings use this
structure for the compatible strings everywhere.

So since generic has no vendor, we fill just the soc_model-function
part leading to:
generic-ohci
generic-ehci

And possible also:
generic-uhci
generic-xhci

So I'm going to respin my 2 fixup patches to move from ?hci-platform
to generic-?hci.

Regards,

Hans
