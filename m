From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Feb 2014 18:04:32 +0100
Subject: ohci-/ehci-platform: Change compatible string to ?hci-platform
In-Reply-To: <4195343.2rfzYCCiXV@lenovo>
References: <Pine.LNX.4.44L0.1402111023240.1209-100000@iolanthe.rowland.org>
 <1635726.gc3dEs0zOi@wuerfel> <4195343.2rfzYCCiXV@lenovo>
Message-ID: <52FA5820.9080905@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 02/11/2014 06:01 PM, Florian Fainelli wrote:
> Le mardi 11 f?vrier 2014, 16:43:37 Arnd Bergmann a ?crit :
>> On Tuesday 11 February 2014 10:27:12 Alan Stern wrote:
>>> It might even be a good idea to change the "xhci-platform" string to
>>> match, it that doesn't cause too much trouble.
>>
>> The original xhci binding was contributed by Al Cooper, but I don't
>> see any dts files using it. I agree that xhci-generic is a better
>> name than xhci-platform, and I think we should make that the recommended
>> string. If Al or someone thinks the xhci-generic string might already
>> be used in production devices, we should however allow both names
>> in the binding and in the driver.
> 
> The platform on which "xhci-platform" is currently used is Broadcom STB for 
> which Marc submitted the base support recently. The BCM7445 reference DTS will 
> probably be updated at some point to reflect that.

Note I've just send a patch with the xhci-platform -> generic-xhci change
Arnd requested. I've left xhci-platform in the list of compatible strings
for now (marked as deprecated in the docs), so there should be no issues
regardless of what the dts version getting merged ends up using.

Would be good if we could ensure it uses generic-xhci though, and then
drop the xhci-platform compatible all-together in a follow-up patch.

Regards,

Hans
