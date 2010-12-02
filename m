From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 2 Dec 2010 14:23:48 +0100
Subject: [PATCH] mmci: supply per-instance regulator name
In-Reply-To: <20101202130809.GD859@rakim.wolfsonmicro.main>
References: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com>
	<20101202120318.GB3182@sirena.org.uk>
	<20101202122827.GG29347@n2100.arm.linux.org.uk>
	<20101202130809.GD859@rakim.wolfsonmicro.main>
Message-ID: <AANLkTikXAvjDOYETutyY7+3aRmWbv9roMHONscNZM-E-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/2 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Thu, Dec 02, 2010 at 12:28:27PM +0000, Russell King - ARM Linux wrote:
>
>> The way the MMCI code is, it only requests one regulator per AMBA
>> device, and therefore only one regulator per struct device. ?So I
>> don't think the current code needs changing in any way provided the
>> struct device is used to find the corresponding regulator.
>
> Hrm. ?In that case I'm not sure what the problem Linus' patch fixes is -
> the driver is already requesting using the struct device, I was assuming
> that the supplies weren't being requested in a fine grained enough
> fashion.

Probably it's the platform board regulator config that needs fixing
instead, so as to bind to the correct device.
I'll check...

I'll do another patch that simply gets rid of the #ifdef for now
instead.

Thanks,
Linus Walleij
