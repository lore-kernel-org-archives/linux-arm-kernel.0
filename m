From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Tue, 13 Nov 2018 11:06:03 +0100
Subject: [PATCH v2 05/11] Doc: DT: thermal: new irq-mode for trip point
In-Reply-To: <CAJKOXPedw6OD1fWWVkYozgR03AWKz5t_-vWw0MV1jVGVR_UGTA@mail.gmail.com>
References: <CGME20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b@eucas1p2.samsung.com>
 <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
 <1541610593-28542-6-git-send-email-l.luba@partner.samsung.com>
 <CAJKOXPedw6OD1fWWVkYozgR03AWKz5t_-vWw0MV1jVGVR_UGTA@mail.gmail.com>
Message-ID: <99e23b0a-ebe7-5c6b-05a7-14d49965b1e1@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Thanks for the comments.

On 11/12/18 9:51 AM, Krzysztof Kozlowski wrote:
> On Wed, 7 Nov 2018 at 18:10, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
> 
> Subject prefix:
> dt-bindings: thermal:
> 
>> Thermal trip point gets new flag in DT: irq-mode.
>> Trip point may have a new explicit flag which indicate
>> IRQ support when the temperature is met (so the thermal framework
>> deos not need to set polling for it).
>> It is useful for 'passive' cooling trip point,
>> which now will not register for polling the temperature.
> 
> You wrap lines in weird way making it more difficult to read.
> I already asked about this while reviewing v1. Please fix it.
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L633
>
I will fix it in v3.
>>
>> Update documentation about irq-mode for trip points.
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree at vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/thermal.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index ca14ba9..bee21e3 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -90,6 +90,10 @@ Required properties:
>>          "critical":     Hardware not reliable.
>>     Type: string
>>
>> +- irq-mode:            A flag indicating that trip rises irq, so there is no
> 
> "rises IRQ" (it is an abbreviation).
ACK
> 
> Best regards,
> Krzysztof
> 


Regards,
Lukasz
