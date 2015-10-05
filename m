From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 5 Oct 2015 04:15:18 +0200
Subject: [PATCH v4 07/26] ARM: pxa: magician: Fix HTC Magician pin mux
 definitions
In-Reply-To: <1443875409.4186.20.camel@gmail.com>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609ADF5.9070003@tul.cz>
 <1443875409.4186.20.camel@gmail.com>
Message-ID: <5611DD36.5030108@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 3.10.2015 v 14:30 Philipp Zabel napsal(a):
> Am Montag, den 28.09.2015, 23:15 +0200 schrieb Petr Cvek:
>> This patch fixes a pin mux for the HTC Magician machine. Wrong and
>> missing
>> definitions caused a bad LCD operation and an unavailability of
>> several
>> peripherals.
>>
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> 
> NAK on this one. Until this patch I can boot my o2 Xda mini with
> Toppoly display and see the framebuffer kernel console output. Can we
> split the LCD changes from the rest, I assume those are what breaks my
> display.

I read the Toppoly datasheet and it seems, the LCD panel implements V/HSYNC, while Samsung does not (and I'm sure at least one of these sync pins must be GPIO for DC-DC control). A solution is probably to reconfigure the GPIO muxes by detected LCD type.

> 
> best regards
> Philipp
> 

Petr
