From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 10 Jun 2010 15:14:52 +0200
Subject: usb gadget on zaurus and kexec
In-Reply-To: <201006100900.23981.marek.vasut@gmail.com> (Marek Vasut's message
	of "Thu, 10 Jun 2010 09:00:23 +0200")
References: <20100519154618.GA26381@atrey.karlin.mff.cuni.cz>
	<AANLkTim49akRJK0BN_Qk1wL6e5mrdjZioDjGNWlrjUVQ@mail.gmail.com>
	<AANLkTilCvgvf9Ch55f878nTNTue8tHYmcrLEywsjnylY@mail.gmail.com>
	<201006100900.23981.marek.vasut@gmail.com>
Message-ID: <87wru7xc4z.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

>> > Dumping out the registers of the two situations and doing a comparison
>> > then might be a quick way.
>> 
>> Any debugging update on this?
>
> Yeah, there's a workaround. Cyril's working on a proper fix, but that might take 
> some time. Simply -- UP2OCR is misconfigured.

That's quite interesting. In the pxa27x_udc gadget driver, I seem to have a
regression on the resume from suspend to RAM path. My USB UDC is not enumerated
anymore.

The might be a correlation, as UP2OCR is lost in the suspend process. I'm very
interested by your analysis of the issue you have on kexec, as that might ease
my work :)

Besides, it's been some time I've been thinking that the pxa deserves a proper
encapsulation of the USB internal routing paths (ie. a proper way to switch from
usb host handled by ohci-pxa27x to an usb client handled by pxa2x_udc), to
reflect the setup of the Pad Unit (see TRM chapter 12.4 : tables 12.2, 12.15,
12.17, 12.18 and 12.19).

Whatever you find on the USB Port2 configuration register would help me design
the Pad block.

Cheers.

--
Robert
