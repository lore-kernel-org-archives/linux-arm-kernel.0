From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 21 Jun 2017 09:26:51 +0000
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <20170620211536.GM4902@n2100.armlinux.org.uk>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
 <20170620100348.zh4ygvjjgnhxvmvl@piout.net> <20170620121011.GA13221@amd>
 <20170620122400.sm7qqvwyj6cuzarw@piout.net> <20170620132620.GA16881@amd>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD96FCD@SW-EX-MBX02.diasemi.com>
 <20170620134458.GA10104@amd> <20170620134827.ubvzhh25klaotupv@piout.net>
 <CA+M3ks68+z6nDtYM8CDpso7SxjB6Nt5E=rOc1yxx=kDz6PUeVQ@mail.gmail.com>
 <20170620211536.GM4902@n2100.armlinux.org.uk>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00278C0@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux
> Sent: 20 June 2017 22:16
..
> Consider that at the moment, we define the 32-bit RTC representation to
> start at a well known epoch.  We _could_ decide that when it wraps to
> 0x80000000 seconds, we'll define the lower 0x40000000 seconds to mean
> dates in the future - and keep rolling that forward each time we cross
> another 0x40000000 seconds.  Unless someone invents a real time machine,
> we shouldn't need to set a modern RTC back to 1970.

True, just treating the value as unsigned gives another 67 years.

If a 32bit RTC is programmed with the low 32bits of the 64bit 'seconds
since 1970' the kernel should have no real difficulty sorting out the
high bits from other available information.

Problems with things like the x86 bios setting the rtc to stupid values
are another matter.
ISTR the rtc chip has a bit for 'summertime' that is never set, on a
multi-os system you can get multiple summer time changes.

	David
