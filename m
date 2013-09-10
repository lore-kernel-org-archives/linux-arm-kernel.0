From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 10 Sep 2013 16:17:54 -0600
Subject: [PATCH v9 1/3] gpio: bcm281xx: Add GPIO driver
In-Reply-To: <522F8BB0.6010301@broadcom.com>
References: <1378836423-12467-1-git-send-email-markus.mayer@linaro.org>
 <1378836423-12467-2-git-send-email-markus.mayer@linaro.org>
 <522F7AE3.6050105@wwwdotorg.org> <522F8BB0.6010301@broadcom.com>
Message-ID: <522F9A92.1040205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2013 03:14 PM, Christian Daudt wrote:
> Hi Stephen,
> On 13-09-10 01:02 PM, Stephen Warren wrote:
>> On 09/10/2013 12:07 PM, Markus Mayer wrote:
>>> From: Markus Mayer <mmayer@broadcom.com>
>>>
>>> Add the GPIO driver for the Broadcom bcm281xx family of mobile SoCs.
>>> These GPIO controllers may contain up to 8 banks where each bank
>>> includes 32 pins that can be driven high or low and act as an edge
>>> sensitive interrupt.
>> The binding,
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>>
>> although ...
>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
>>> b/Documentation/devicetree/bindings/gpio/gpio-bcm-kona.txt
>>> +This GPIO driver is used in the following Broadcom SoCs:
>>> +  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
>> Given that, I would expect the documentation of the compatible property
>> to enumerate the compatible values for all of those different chips,
>> although the driver could choose to only bind to e.g. brcm,bcm11351-gpio
>> or brcm,kona-gpio, since they're all compatible with it.
>>
> How would this help ? All of these chips are part of the same family and
> thus quite similar (the primary difference being on the memory
> controller and packaging), and we can't know a priori on which
> variations bugs will happen, if any.

That's exactly why the DT should include a compatible value that
precisely describes the chip; so that information is there if it's
needed in the future.
