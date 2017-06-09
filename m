From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 9 Jun 2017 19:36:56 +0200
Subject: [linux-sunxi] Re: [PATCH v2] arm64: allwinner: a64: Add initial
 NanoPi A64 support
In-Reply-To: <3b4dda48-c403-88c4-5c89-63753f508d76@arm.com>
References: <1497012052-14027-1-git-send-email-jteki@openedev.com>
 <1497012052-14027-2-git-send-email-jteki@openedev.com>
 <20170609145141.aknbsis25vmy3rj6@flea.home>
 <3049841d-36f0-a761-fbed-57971462697c@openedev.com>
 <3b4dda48-c403-88c4-5c89-63753f508d76@arm.com>
Message-ID: <f6763317-b970-529e-79af-947ba2dae9a2@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 09.06.2017 um 17:36 schrieb Andre Przywara:
> On 09/06/17 16:26, Jagan Teki wrote:
>> On Friday 09 June 2017 08:21 PM, Maxime Ripard wrote:
>>> On Fri, Jun 09, 2017 at 12:40:52PM +0000, Jagan Teki wrote:
>>>> +&uart1 {
>>>> +    pinctrl-names = "default";
>>>> +    pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
>>>> +    status = "okay";
>>>> +};
>>>
>>> And [what is connected] on that UART?
>>
>> uart1 for SDIO (Wifi connector, with RTS/CTS), this along with mmc1
> 
> To be precise, UART1 (with h/w handshake) is connected to the Bluetooth
> part of the WiFi/BT chip, which is soldered on that board. Regardless of
> the actual *WiFi* support state BT should work already - at least it did
> when I tried this a few months ago on the Pine64 (although this involved
> some userland heavy lifting).
> Not sure what the approach here is in regard to the power supply and
> wake-up GPIOs, shall they be described in this node as well or is that
> up for userspace to control?

You should use a serdev based Bluetooth driver by adding a sub-node, and
it should take care of any reset GPIOs etc. for you. Question is which
driver is needed here and what state it is in.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
