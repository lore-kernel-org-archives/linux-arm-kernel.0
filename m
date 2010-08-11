From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Thu, 12 Aug 2010 00:31:14 +0200
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <20100811201332.GB10379@kroah.com>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>
	<20100811095454.GA22543@n2100.arm.linux.org.uk>
	<AANLkTimX46QKAGhiyo8AodaXVjuzoxr5-5z2V4gRr1Vu@mail.gmail.com>
	<20100811150443.GB8867@kroah.com>
	<AANLkTimmJDKbh3_pRY_ASKvjsf4YuuUMh3edh5LvDv-p@mail.gmail.com>
	<20100811174238.GA12382@kroah.com> <4C62F4EF.1050808@gmail.com>
	<20100811201332.GB10379@kroah.com>
Message-ID: <4C6324B2.2080606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg KH wrote:
> Can you fix this in the host controller driver?
>
>   
Technically yes (by copying the unaligned buffers).

But if we do decide that USB must support unaligned buffers wouldn't it
be better to have the HCD indicate it's alignment requirement to the
core and have the core do the copying?

Gary King sent a message to this thread but only to the arm list saying
he has the same problem with the tegra hcd (which doesn't seem to be in
the tree yet.)  I don't know if any of the other in tree HCDs have this
problem.

Also if this is a new requirement for HCDs usbtest probably needs a new
test...

Martin
