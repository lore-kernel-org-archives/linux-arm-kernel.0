From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 10 Apr 2015 12:55:02 +0200
Subject: [PATCH RFC] ARM: BCM5301X: Add /device_id property including
 device ID string
In-Reply-To: <24438163.XzJnLCdvP5@wuerfel>
References: <1427667288-23903-1-git-send-email-zajec5@gmail.com>
 <CACna6rykQq6AVSWzJh3qnHVNzPXbTD9TMGQf9D9p50pcbQkmng@mail.gmail.com>
 <20150330105828.GE17971@leverpostej> <24438163.XzJnLCdvP5@wuerfel>
Message-ID: <CACna6rzmACyJ6=EJCCi2eCp1A8cCLJiusm7=pyHQM0QL+82Zng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2015 at 12:50, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 30 March 2015 11:58:29 Mark Rutland wrote:
>> > > On Sun, Mar 29, 2015 at 11:14:48PM +0100, Rafa? Mi?ecki wrote:
>> > >> Device vendors often assign IDs to their devices to allow comparing
>> > >> firmware image with device model. This is required to prevent users
>> > >> from flashing incompatible image and soft-bricking device.
>> > >> Add device_id property to DTs to allow user space (and optionally
>> > >> bootloader) verifying firmware images.
>> > >
>> > > This sounds like exactly what the "model" property is meant to be (per
>> > > ePAPR) -- a string that specifices the manufacturer's model number of
>> > > the device, ideally in "manufacturer,model" format.
>> >
>> > What if manufacturer decided to use some totally unfriendly ID for
>> > their low-level (firmware upgrade) model identification? I can't
>> > really see us using
>> > model  "U12H245T00_NETGEAR"
>> > which would mean nothing compared to the current friendly:
>> > model  "Netgear R6250 V1 (BCM4708)"
>>
>> If it uniquely identifies the model, it's fit to be a model string. If
>> being "friendly" means that we lose that, then the property is useless
>> anyway.
>>
>> Note that both examples above deviate from the recommended format, and
>> something like: "netgear,U12H245T00" would better align with the
>> recommendation.
>
> Sorry for jumping in late here, but this still sounds like more fitting
> for the "compatible" property than "model". For compatible, you can
> already have multiple strings, and they come with a vendor prefix.
>
> Any of these would seem reasonable to me:
>
> a)
>         compatible = "asus,rt-ac68u", "openwrt,RT-AC68U", "brcm,bcm4708";
>         model = "Asus RT-AC68U (BCM4708)";
>
> b)
>         compatible = "asus,rt-ac68u", "brcm,RT-AC68U", "brcm,bcm4708";
>         model = "Asus RT-AC68U (BCM4708)";
>
> c)
>         compatible = "asus,rt-ac68u", "asus,RT-AC68U", "brcm,bcm4708";
>         model = "Asus RT-AC68U (BCM4708)";
>
> depending on which party maintains the list of these identifiers.

Thanks, I think it looks like the best alternative to my initial idea.

-- 
Rafa?
