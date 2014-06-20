From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Jun 2014 16:27:24 +0200
Subject: [PATCH v2 1/4] dt: bindings: add bindings for Broadcom bcm43xx
 sdio devices
In-Reply-To: <539FF2FA.8050304@broadcom.com>
References: <1402941407-8210-1-git-send-email-hdegoede@redhat.com>
 <1402941407-8210-2-git-send-email-hdegoede@redhat.com>
 <CAGVrzcZBzDTfnd6o0ib1FBvBK2VPNitS=rpb4jDkjF=T7Fy=DQ@mail.gmail.com>
 <539FE0EC.5090003@redhat.com> <539FF2FA.8050304@broadcom.com>
Message-ID: <53A444CC.2080203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/17/2014 09:49 AM, Arend van Spriel wrote:
> On 17-06-14 08:32, Hans de Goede wrote:
>> Hi,
>>
>> On 06/16/2014 10:53 PM, Florian Fainelli wrote:
>>> 2014-06-16 10:56 GMT-07:00 Hans de Goede <hdegoede@redhat.com>:
>>>> From: Arend van Spriel <arend@broadcom.com>
>>>>
>>>> The Broadcom bcm43xx sdio devices are fullmac devices that may be
>>>> integrated in ARM platforms. Currently, the brcmfmac driver for
>>>> these devices support use of platform data. This patch specifies
>>>> the bindings that allow this platform data to be expressed in the
>>>> devicetree.
>>>>
>>>> Reviewed-by: Hante Meuleman <meuleman@broadcom.com>
>>>> Reviewed-by: Franky (Zhenhui) Lin <frankyl@broadcom.com>
>>>> Reviewed-by: Daniel (Deognyoun) Kim <dekim@broadcom.com>
>>>> Reviewed-by: Pieter-Paul Giesberts <pieterpg@broadcom.com>
>>>> Signed-off-by: Arend van Spriel <arend@broadcom.com>
>>>> [hdegoede at redhat.com: drop clk / reg_on gpio handling, as there is no consensus
>>>>   on how to handle this yet]
>>>> [hdegoede at redhat.com: move from bindings/staging to bindings]
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>   .../bindings/net/wireless/brcm,bcm43xx-fmac.txt    | 29 ++++++++++++++++++++++
>>>>   1 file changed, 29 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
>>>> new file mode 100644
>>>> index 0000000..6a0aaf2
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
>>>> @@ -0,0 +1,29 @@
>>>> +Broadcom BCM43xx Fullmac wireless SDIO devices
>>>> +
>>>> +This node provides properties for controlling the Broadcom wireless device. The
>>>> +node is expected to be specified as a child node to the SDIO controller that
>>>> +connects the device to the system.
>>>> +
>>>> +Required properties:
>>>> +
>>>> + - compatible : Should be "brcm,bcm43xx-fmac".
>>>
>>> In general, the use of a wildcard compatible string is discouraged
>>> over the use of a more descriptive compatible string. So you should
>>> find out what is the first chip that is compatible, and use that
>>> compatible string as long as that compatibility remains.
>>
>> Right, Arend, what should we use then ?
> 
> In earlier discussions, we ended up with this compatible string. The properties are generic enough to be covered by this 'wildcard' string. However, I am not religious about it so if you feel strongly for an explicit string it could be brcm,bcm4329-fmac, but it does not have my preference.

It is not something I really feel strong about, but as Florian
rightfully points out using wildcard strings is something which
is more or less not done in devicetree land, the idea being that
just using the lowest model, makes it easier to later add different
bindings for later models if that turns out to be necessary.

So I've changed the compatibility string to brcm,bcm4329-fmac for v3
of this patch-set.

Regards,

Hans
