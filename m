From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 9 Nov 2012 20:53:40 +0100
Subject: [PATCH] i2c: at91: fix SMBus quick command
In-Reply-To: <1352481797-3520-1-git-send-email-ludovic.desroches@atmel.com>
References: <1352481797-3520-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20121109205340.28e5772f@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Nov 2012 18:23:17 +0100, ludovic.desroches at atmel.com wrote:
> I tested it with i2cdetect as you suggested. EEPROMs were detected but not
> other devices (lm75 and ds1337). I have exactly the same behavior by using
> i2c-gpio driver so I think there is no major issue on a driver point of view.

Note that i2cdetect uses a different probe command for EEPROM addresses
(0x50-0x57) than for other addresses by default. You can change this
default behavior with -q and -r for testing purposes.

-- 
Jean Delvare
