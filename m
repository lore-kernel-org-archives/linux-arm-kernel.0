From: eric@anholt.net (Eric Anholt)
Date: Mon, 18 May 2015 10:34:08 -0700
Subject: [PATCH 2/3 v2] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <5558DD40.4070701@tronnes.org>
References: <1431543609-19646-1-git-send-email-eric@anholt.net>
 <1431543609-19646-3-git-send-email-eric@anholt.net>
 <5558DD40.4070701@tronnes.org>
Message-ID: <87pp5xokmn.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Noralf Tr?nnes <noralf@tronnes.org> writes:

> Den 13.05.2015 21:00, skrev Eric Anholt:
>> This gives us a function for making mailbox property channel requests
>> of the firmware, which is most notable in that it will let us get and
>> set clock rates.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>
> [...]
>
>> +/*
>> + * Submits a single tag to the VPU firmware through the mailbox
>> + * property interface.
>> + *
>> + * This is a convenience wrapper around
>> + * rpi_firmware_property_list() to avoid some of the
>> + * boilerplate in property calls.
>> + */
>> +int rpi_firmware_property(struct device_node *of_node,
>> +			  u32 tag, void *tag_data, size_t buf_size)
>
> To use the firmware property functions, I need a DT node pointer.
> Since Device Tree is dynamic now, should I fetch the firmware node
> each time, or should I do that in probe and store the node pointer?
>
> Device Tree:
>          firmware: firmware {
>              compatible = "raspberrypi,firmware";
>          };
>
>          thermal {
>              compatible = "brcm,bcm2835-thermal";
>              firmware = <&firmware>;
>          };

I'm doing it in probe in my clients -- I don't see why the firmware
device's node would change.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150518/8519ace7/attachment.sig>
