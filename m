From: romain.izard.pro@gmail.com (Romain Izard)
Date: Mon, 6 Feb 2017 16:14:31 +0100
Subject: Fractional divider on the Atmel USART controller
In-Reply-To: <20170206134256.tp5rgx6axd532gp3@rfolt0960.corp.atmel.com>
References: <CAGkQfmNshOGWT8Vs_J-49qq2UHoCMJ8cYb9jbjaDqM2YNy05rg@mail.gmail.com>
 <20170206134256.tp5rgx6axd532gp3@rfolt0960.corp.atmel.com>
Message-ID: <CAGkQfmPHmc+7fnD78KbyMLgmdSsCddGC07vSWFm-RVWanh6Ttg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-06 14:42 GMT+01:00 Ludovic Desroches <ludovic.desroches@microchip.com>:
> Hello Romain,
>
> On Mon, Feb 06, 2017 at 12:56:42PM +0100, Romain Izard wrote:
>>
>> Unfortunately, I know that this will work on SAMA5D2, but this driver is
>> used for many other Atmel chips. I do not know if the existing code is
>> meant to respect a known limitation on other devices that use the same
>> controller, or if it is just a bug.
>
> It depends on the device used. In the SAMA5D4 datasheet, it is
> mentionned: "This feature is only available when using USART normal mode".
>
> In the SAMA5D2 datasheet, this constraint is no longer mentionned you
> confirm that is works, that is great.
>

For verification, I checked the SAMA5D2 datasheet, and (in rev. D) the
warning is still present in ?41.7.1.2. Unfortunately, I did not test the
CTS/RTS mode directly, and I would not go as far as claiming that it
works without any reservation.

In my original use case, the hardware handshaking was activated
automatically when loading the HCILL line discipline to access the
Bluetooth part of a TI WL1831 chip. Fixing the baud rate issue was
enough to restore the Bluetooth stack to the working state I had when I
used the linux4sam 5.3 branch, but I am not sure of how the handshaking
is really used in practice.

Best regards,
-- 
Romain Izard
