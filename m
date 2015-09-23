From: emilio.lopez@collabora.co.uk (=?UTF-8?Q?Emilio_L=c3=b3pez?=)
Date: Wed, 23 Sep 2015 11:31:22 -0300
Subject: [PATCH v3 2/4] Documentation: bindings: mfd: cros ec: document
 vbc EC property
In-Reply-To: <20150923003401.GB16510@x1>
References: <1442842703-5309-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1442842703-5309-3-git-send-email-emilio.lopez@collabora.co.uk>
 <20150923003401.GB16510@x1>
Message-ID: <5602B7BA.8020302@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 22/09/15 21:34, Lee Jones wrote:
> On Mon, 21 Sep 2015, Emilio L?pez wrote:
>
>> Some EC implementations include a small nvram space used to store
>> verified boot context data. This boolean property lets us indicate
>> whether this space is available or not on a specific EC implementation.
>>
>> Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
>> ---
>>
>> Patch is new in v3, split from 3/4
>>
>>   Documentation/devicetree/bindings/mfd/cros-ec.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
>> index 1777916..136e0c2 100644
>> --- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
>> +++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
>> @@ -34,6 +34,10 @@ Required properties (LPC):
>>   - compatible: "google,cros-ec-lpc"
>>   - reg: List of (IO address, size) pairs defining the interface uses
>>
>> +Optional properties (all):
>> +- google,has-vbc-nvram: Some implementations of the EC include a small
>> +  nvram space used to store verified boot context data. This boolean flag
>> +  is used to specify whether this nvram is present or not.
>
> Is there no way to check for this at runtime?

You can issue a read and see if it succeeds, but the problem is that 
some EC implementations return success even when they don't implement 
the functionality.

Cheers,

Emilio
