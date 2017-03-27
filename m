From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 27 Mar 2017 11:28:42 +0530
Subject: [PATCH 1/2] drm/bridge: ti-tfp410: support hpd via gpio
In-Reply-To: <6dfb2b66ec2a408dabe80d703f411ce0@rwthex-s1-b.rwth-ad.de>
References: <2e47786ab3d04078ae70d0c4064f7c4d@rwthex-s1-b.rwth-ad.de>
 <093b4e9c0ae6413499e5bf8ec309fa41@rwthex-s1-b.rwth-ad.de>
 <6dfb2b66ec2a408dabe80d703f411ce0@rwthex-s1-b.rwth-ad.de>
Message-ID: <d6b2391f-3e4a-2761-b6a0-8997d2c78600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/07/2017 03:21 AM, Christopher Spinrath wrote:
> Hi Fabio,
>
> On 03/06/2017 10:46 PM, Fabio Estevam wrote:
>> Hi Christopher,
>>
>> On Mon, Mar 6, 2017 at 6:40 PM,  <christopher.spinrath@rwth-aachen.de> wrote:
>>> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>>>
>>> On some boards the hpd pin of a hdmi connector is wired up to a gpio
>>> pin. Since in the DRM world the tfp410 driver is responsible for
>>> handling the connector, add support for hpd gpios in this very driver.
>>>
>>> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>>> ---
>>>  drivers/gpu/drm/bridge/ti-tfp410.c | 72 ++++++++++++++++++++++++++++++++++++--
>>
>> It would be nice to add 'hpd-gpios' property in the binding doc as well:
>> Documentation/devicetree/bindings/display/bridge/ti,tfp410.txt
>
> The hpd-gpios property does *not* belong to the ti,tfp410 binding but to the hdmi-connector one
> where it is already documented:
> Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
>
> Unfortunatly, there is no dedicated driver for the connector in Linux; the connector properties have
> to be handled by the encoder (here  the tfp410) driver. Note that this already happens for the
> ddc-i2c-bus property.
>

The patch looks good to me.

Jyri,

Is it possible for you to verify this on Beaglebone platform?

Thanks,
Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
