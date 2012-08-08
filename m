From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Aug 2012 16:28:24 +0200
Subject: [rtc-linux] [PATCH 8/8] ARM: vt8500: gpio: Devicetree support for
 arch-vt8500
In-Reply-To: <201208080919.52592.arnd@arndb.de>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-9-git-send-email-linux@prisktech.co.nz>
 <CACRpkdbYxpN9RCu8j8KMBgrb=-DsYZHq7hx-ifmHhJ0ZZcRYjw@mail.gmail.com>
 <201208080919.52592.arnd@arndb.de>
Message-ID: <CACRpkdabUWpDsBhz4ZEJNhEuqw-U+v-HrX7NcWoNLeuenv5t9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 11:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:

>> What on earth are all those magic numbers?
>>
>> I *guess* they're enabling some default GPIO settings etc.
>
> No, they are the register offsets you quoted above, per bank.

Aha I was fooled by this:

+struct vt8500_gpio_bank_regs {
+       int     en;
+       int     dir;
+       int     data_out;
+       int     data_in;
+       int     ngpio;
+};

This needs to be named something intuitive like "vt8500_gpio_bank_regoffsets"

Some kerneldoc intsead of the opaque comment above will also improve
readability a lot:

/**
  * struct vt8500_gpio_bank_regoffsets
  * @en: offset to enable register in the bank
  * ...

Yours,
Linus Walleij
