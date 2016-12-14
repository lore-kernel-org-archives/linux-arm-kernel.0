From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Dec 2016 10:00:46 +0100
Subject: [PATCH linux v1 4/4] arm: dts: Add dt-binding to support seven
 segment display on zaius
In-Reply-To: <3917905.e4iOqADnVQ@wuerfel>
References: <1481702104-8617-1-git-send-email-jaghu@google.com>
 <1481702104-8617-5-git-send-email-jaghu@google.com>
 <3917905.e4iOqADnVQ@wuerfel>
Message-ID: <10697525.O7CkPN6Gfl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 14, 2016 9:55:47 AM CET Arnd Bergmann wrote:
> According to your introductory mail, the interface is assumed to be
> a 74HC164. Should we use that ID in the compatible string?
> 
> We can always add other strings later if we want to support multiple
> wire formats.

Actually, looking up 74hc164, that seems to be a gpio expander,
so maybe a more flexible way to do the same is to put a driver
for the expander into drivers/gpio/ and have the main driver
access the outputs of that using the gpiolib interface.

	Arnd
