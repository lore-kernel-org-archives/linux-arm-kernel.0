From: virtuoso@slind.org (Alexander Shishkin)
Date: Mon, 19 Oct 2009 15:57:41 +0300
Subject: [PATCH v2 1/2] arm: a driver for on-chip ETM and ETB
In-Reply-To: <20091013174413.GA1134@n2100.arm.linux.org.uk>
References: <1255453611-16119-1-git-send-email-virtuoso@slind.org>
	<20091013174413.GA1134@n2100.arm.linux.org.uk>
Message-ID: <71a0d6ff0910190557q25cb1da2o1bcd6bdd5348c881@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Oct 13, 2009 at 08:06:50PM +0300, Alexander Shishkin wrote:
>> Changes:
>> v2 -- major update:
>> ? ? ? * fixes according to comments from Linus Walleij and Anand Gadiyar
>> ? ? ? * omap3 clock-related stuff moved to platform device
>
> And so what about my comments?
Ah, sorry about that. It was just that the same comments were given by
Linus, so my reply regarding those was to him.

Generally, my concern was that to make not all of the ETM versions
even have a memory-mapped registers (earlier versions use cp14
instead; I don't support those at the moment, but it might be a nice
thing to do that in future) and some of the registers which the AMBA
framework seems to rely (peripheral id and component id) on are only
available since ETMv3.2. And the most recent version mentioned in "ETM
architecture" document is 3.4.

That said, I'm personally not overly concerned about the support for
earlier versions of those macrocells and if you maintain that those
are better off implemented as AMBA drivers, I've not problem doing
that.

Regards,
--
Alex
