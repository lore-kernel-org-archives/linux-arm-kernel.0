From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Feb 2014 16:21:10 +0100
Subject: [PATCH 1/2] ohci-platform: Change compatible string from usb-ohci
 to ohci-platform
In-Reply-To: <954E6E26-EEF1-4A0A-A9BC-D5CA918FAD43@codeaurora.org>
References: <1392127826-31290-1-git-send-email-hdegoede@redhat.com>
 <1392127826-31290-2-git-send-email-hdegoede@redhat.com>
 <954E6E26-EEF1-4A0A-A9BC-D5CA918FAD43@codeaurora.org>
Message-ID: <52FA3FE6.8040308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/11/2014 04:06 PM, Kumar Gala wrote:
> 
> On Feb 11, 2014, at 8:10 AM, Hans De Goede <hdegoede@redhat.com> wrote:
> 
>> The initial versions of the devicetree enablement patches for ohci-platform
>> used "ohci-platform" as compatible string. However this was disliked by various
>> reviewers because the platform bus is a Linux invention and devicetree is
>> supposed to be OS agnostic. After much discussion I gave up and went with
>> the generic usb-ohci as requested.
>>
>> In retro-spect I should have stuck to my guns, because the dts files for many
>> existing boards already claim to be compatible with "usb-ohci", ie they have:
>>
>> 	compatible = "ti,ohci-omap3", "usb-ohci";
>>
>> In theory this should not be a problem since the "ti,ohci-omap3" entry takes
>> presedence, but in practice using a conflicting compatible string is an issue,
>> because it makes which driver gets used depent on driver registration order.
>>
>> This patch changes the compatible string claimed by ohci-platform (back) to
>> "ohci-platform", avoiding the driver registration / module loading ordering
>> problems. Note that there already is a precedent for using ?hci-platform, in
>> the form of xhci-platform.c using "xhci-platfrom" as compatible string.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Documentation/devicetree/bindings/usb/usb-ohci.txt | 4 ++--
>> drivers/usb/host/ohci-platform.c                   | 2 +-
>> 2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-ohci.txt b/Documentation/devicetree/bindings/usb/usb-ohci.txt
>> index 6933b0c..a8e576a 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-ohci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-ohci.txt
>> @@ -1,7 +1,7 @@
>> USB OHCI controllers
>>
>> Required properties:
>> -- compatible : "usb-ohci?
> 
> Why not leave ?usb-ohci? and deprecate it?

As it was introduced just a couple of days ago in linux-next, and has never seen
the light in any released kernel.

Regards,

Hans
