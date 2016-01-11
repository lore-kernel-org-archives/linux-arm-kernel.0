From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Mon, 11 Jan 2016 09:33:21 -0600
Subject: [PATCH] ata: add AMD Seattle platform driver
In-Reply-To: <5690367E.8060609@amd.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
 <4983521.tEaWggKCCv@wuerfel> <568F14E0.4060107@amd.com>
 <10869853.plxna0HzWE@wuerfel> <5690367E.8060609@amd.com>
Message-ID: <5693CB41.70408@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2016 04:21 PM, Brijesh Singh wrote:
> Hi,

>> We generally don't refer to register locations with properties other than
>> 'reg', so that approach would be worse. What I'd suggest you do is to
>> have the sgpio registers in a separate device node, and use the LED
>> binding to access it, see
>>
>> Documentation/devicetree/bindings/leds/common.txt
>>
>> It seems that none of the drivers/ata/ drivers use the leds interface
>> today, but that can be added to libata-*.c whenever the appropriate
>> properties are there.
>>
>
> libata-*.c implements the "Enclosure management" style led messages but also has hooks
> to register a custom led control callback. Since Seattle platform does not support
> the "Enclosure management" registers hence ata_port_info we are setting a ATA_FLAG_EM | ATA_FLAG_SW_ACIVITY
> to indicate that we can still handle the led messages by our registered callback. I see
> that sata_highbank driver is doing something similar.

The sata_highbank driver is doing it wrong and shouldn't have been
accepted in its current condition. Enclosure management really should
be a separate device. Please don't use it as an example.

--Mark Langsdorf
