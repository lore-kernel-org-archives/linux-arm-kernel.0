From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 6 Jul 2018 16:35:38 +0100
Subject: [PATCH 05/10] arm64: dts: allwinner: a64: Olinuxino: enable USB
In-Reply-To: <20180706150401.mhqse677vdqtxdzy@nodbug.lucina.net>
References: <20180706085210.17952-1-andre.przywara@arm.com>
 <20180706085210.17952-6-andre.przywara@arm.com>
 <20180706150401.mhqse677vdqtxdzy@nodbug.lucina.net>
Message-ID: <548f2eb5-b457-8fcd-c043-b897a447d96c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/07/18 16:04, Martin Lucina wrote:
> On Friday, 06.07.2018 at?09:52, Andre Przywara wrote:
>> The Olinuxino has two USB socket:
>> USB0 is connected to a micro B socket. As it has the ID pin wired, we
>> describe it as a proper OTG socket, which switches between host and
>> device automatically.
>> USB1 is connected to a normal USB A socket. PG9 enables the power line,
>> so add the required regulator as well.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
> 
> This is not sufficient. Booting with this change results in the following
> in dmesg:
> 
> musb-sunxi 1c19000.usb: Invalid or missing 'dr_mode' property
> musb-sunxi: probe of 1c19000.usb failed with error -22
> [...]
> usb0-vbus: disabling
> 
> ... and neither of the USB ports work.
> 
> Adding
> 
>     dr_mode = "host";

Argh, right, I remember you mentioned this before.
Still it should not affect the other USB port, and actually it is a
proper OTG port, so host is not right here. So this points to some other
oddity or incorrect description. I need to go back to the schematics and
our previous thread.

Cheers,
Andre.

> 
> to the &usb_otg node fixes this -- the above messages go away and both
> ports work as expected.
> 
> -mato
> 
