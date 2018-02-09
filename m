From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 08 Feb 2018 16:40:54 -0800
Subject: [PATCH 1/7] dt-bindings: soc: new driver for DaVinci genpd
In-Reply-To: <CAMRc=Me5Qckp=_KpbPYprKb23Ujz1C9Um6FrHK59wY=XA2Jcvg@mail.gmail.com>
 (Bartosz Golaszewski's message of "Thu, 8 Feb 2018 09:56:00 +0100")
References: <20180207134553.13510-1-brgl@bgdev.pl>
 <20180207134553.13510-2-brgl@bgdev.pl>
 <36aebdca-2a7d-07a3-8632-95992d74cae6@lechnology.com>
 <CAMRc=Me5Qckp=_KpbPYprKb23Ujz1C9Um6FrHK59wY=XA2Jcvg@mail.gmail.com>
Message-ID: <7hshab9eqx.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> 2018-02-07 22:47 GMT+01:00 David Lechner <david@lechnology.com>:
>> On 02/07/2018 07:45 AM, Bartosz Golaszewski wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Add a simple document for the DaVinci genpd driver. We use clock pm
>>> exclusively hence no reg property.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>   .../devicetree/bindings/soc/ti,davinci-pm-domains.txt       | 13
>>> +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>>> b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>>> new file mode 100644
>>> index 000000000000..935d063c7b35
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/ti,davinci-pm-domains.txt
>>> @@ -0,0 +1,13 @@
>>> +Device tree bindings for the genpd driver for Texas Instruments DaVinci
>>> SoCs
>>> +
>>> +Required properties:
>>> +
>>> +- compatible:           must be "ti,davinci-pm-domains"
>>> +- #power-domain-cells:  must be 0
>>> +
>>> +Example:
>>> +
>>> +pwc1: power-controller at 227000 {
>>> +       compatible = "ti,davinci-pm-domains";
>>> +       #power-domain-cells = <0>;
>>> +};
>>>
>>
>>
>> We already have the PSC @227000. Why not just add
>> #power-domain-cells = <0>; to that node instead of creating
>> a new "device" when this is really the same device?
>
> I thought about it too, but then noticed that most architectures do
> use a separate genpd driver even if it only calls routines placed in
> their respective clock driver.
>
> Let me prepare a v2 with this approach though.

Yes, I agree with David.  Just making the PSC be a power-controller is a
good approach.

Kevin
