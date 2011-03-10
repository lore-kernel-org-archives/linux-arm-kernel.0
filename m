From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Mar 2011 16:17:54 +0100
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <20110310151014.GA826@n2100.arm.linux.org.uk>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101529.25661.arnd@arndb.de>
	<20110310144455.GG22195@opensource.wolfsonmicro.com>
	<201103101602.19241.arnd@arndb.de>
	<20110310151014.GA826@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=Q+6B1OxP08HvchH1LFcW26fSt7LWio1OkGwJy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 4:10 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Mar 10, 2011 at 04:02:18PM +0100, Arnd Bergmann wrote:
>> The one thing that really doesn't belong in /sys/devices/platform/
>> however are devices that are clearly children of some other
>> device, e.g. a UART behind MFD behind I2C behind AHB.
>
> Who ever thought about putting a UART behind I2C ? ?That's insane!

For immediate entertainment I can tell you we have such a thing in
the AB3100 on the U300, at the other side of an I2C link.

That UART connects to a so-called "smart battery", since the
AB3100 is our mixed-signal device it had the physical connections
to the battery and thus that UART that can talk to the CPU inside
the battery.

There aren't many bauds on this bus, I assure you... yet,
batteries aren't very talkative anyway.

Yours,
Linus Walleij
