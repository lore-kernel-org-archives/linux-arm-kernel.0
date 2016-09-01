From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 1 Sep 2016 10:40:32 +0200
Subject: [linux-sunxi] Re: [PATCH v3] ARM: dts: sun8i: enable UART1 for
 iNet D978 Rev2 board
In-Reply-To: <20160831162240.GJ14379@lukather>
References: <20160829141832.10566-1-icenowy@aosc.xyz>
 <20160831162240.GJ14379@lukather>
Message-ID: <a3097f99-a761-76e7-1405-2574c56ac94d@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 31-08-16 18:22, Maxime Ripard wrote:
> On Mon, Aug 29, 2016 at 10:18:32PM +0800, Icenowy Zheng wrote:
>> UART1 is connected to the bluetooth part of RTL8723BS WiFi/BT combo card
>> on iNet D978 Rev2 board.
>>
>> Enable the UART1 to make it possible to use the modified hciattach by
>> Realtek to drive the BT part of RTL8723BS.
>>
>> On the board no r_uart pins are found now (the onboard RX/TX pins are
>> wired to PF2/PF4, which is muxed with mmc0), so also disabled it.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> I'll make the same comments than in the v2.
> https://www.spinics.net/lists/arm-kernel/msg527001.html

I've a feeling there is a bit of miscommunication here,
let me try to clarify things:

Icenowy, Maxime wants you to split this into 2 patches:

1) Adding just the uart1_pins_a and uart1_pins_cts_rts_a nodes to
sun8i-a23-a33.dtsi; and
2) Another patch with the sun8i-a33-inet-d978-rev2.dts changes

And for 2. Maxime wants you to change:

	aliases {
		/delete-property/serial0;
		serial1 = &uart1;
	};

to:

	aliases {
		serial0 = &uart1;
	};

There is no serial0 and Maxime wants the serial-s
to be numbered starting at 0 (iow there is no reason
to make the bluetooth uart serial1).

Regards,

Hans
