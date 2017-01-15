From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 15 Jan 2017 23:48:36 +0100
Subject: [PATCH 1/4] tty: serial: meson: allow baud-rates higher than
 115200
In-Reply-To: <20170115223255.10350-2-martin.blumenstingl@googlemail.com>
References: <20170115223255.10350-1-martin.blumenstingl@googlemail.com>
 <20170115223255.10350-2-martin.blumenstingl@googlemail.com>
Message-ID: <2a53ef47-a9b5-4015-49a1-dafeb53020eb@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.01.2017 um 23:32 schrieb Martin Blumenstingl:
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

Tested-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
