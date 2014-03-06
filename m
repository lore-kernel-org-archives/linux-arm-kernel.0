From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 6 Mar 2014 10:52:00 +0200
Subject: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
In-Reply-To: <CAMuHMdWVSfKrudBhE7FW-ZWBvMOLWjrQZvn1qZUfRt_H+P7A2w@mail.gmail.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com>	<20140228155937.GQ21483@n2100.arm.linux.org.uk>	<5310B567.7040605@ti.com>	<20140228162327.GT21483@n2100.arm.linux.org.uk>	<5316E31F.9050308@ti.com>
 <CAMuHMdWVSfKrudBhE7FW-ZWBvMOLWjrQZvn1qZUfRt_H+P7A2w@mail.gmail.com>
Message-ID: <53183730.5060205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/14 10:39, Geert Uytterhoeven wrote:
> On Wed, Mar 5, 2014 at 9:41 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> On 28/02/14 18:23, Russell King - ARM Linux wrote:
>>
>>> That's rather a lot of compatible strings.  Another possibility is:
>>>
>>>       compatible = "dvi-connector";
>>>       analog;
>>>       digital;
>>>       single-link;
>>>       dual-link;
>>
>> I made the following changes compared to the posted version. I decided
>> to leave the "single-link" out, as it's implied if "digital" is set.
>>
>>  Tomi
>>
>> @@ -6,11 +6,16 @@ Required properties:
>>
>>  Optional properties:
>>  - label: a symbolic name for the connector
>> -- i2c-bus: phandle to the i2c bus that is connected to DVI DDC
>> +- ddc-i2c-bus: phandle to the i2c bus that is connected to DVI DDC
>> +- analog: the connector has DVI analog pins
>> +- digital: the connector has DVI digital pins
>> +- dual-link: the connector has pins for DVI dual-link
>>
>>  Required nodes:
>>  - Video port for DVI input
>>
>> +Note: One (or both) of 'analog' or 'digital' must be set.
> 
> So dual-link needs both "digital" and "dual-link"?

Yes. It is extra, but it felt clearer to me to have 'digital' as a
matching property for 'analog'.

Alternatively we could have three options:

analog;
digital-single-link;
digital-dual-link;

My reasoning to the format I chose was basically that when a connector
supports 'digital', it contains TMDS clock and TMDS data for link 1.
Adding dual link to that adds only TMDS data for link 2, so the second
data link is kind of an additional feature, marked with a flag.

Not a very big argument, and I'm fine with other format suggestions.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140306/65ecafc2/attachment.sig>
