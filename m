From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 13:44:42 -0800
Subject: [PATCH 1/4] tty: serial: meson: allow baud-rates higher than
 115200
In-Reply-To: <20170115223255.10350-2-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 15 Jan 2017 23:32:52 +0100")
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
 <20170115223255.10350-2-martin.blumenstingl@googlemail.com>
Message-ID: <m2o9z4yred.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The vendor driver allows setting baud-rates higher than 115200 baud.
> There is a check in the vendor driver which prevents using more than
> 115200 baud during startup, however it does not have such a check in
> .set_termios.
> Higher baud-rates are often used by the bluetooth modules embedded into
> the SDIO wifi chips (Amlogic devices use brcmfmac based wifi chips quite
> often, 2000000 baud seems to be a common value for the UART baud-rate in
> Amlogic's "libbt").
>
> I have tested this on a Meson GXL device with uart_A (to which the
> bluetooth module is connected, where initialization times out with
> 115200 baud) and uart_AO (which I manually set to 2000000 baud  and then
> connected with my USB UART adapter to that).
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>
