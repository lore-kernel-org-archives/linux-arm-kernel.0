From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 Jan 2016 13:52:20 +0000
Subject: [PATCH 1/2] regulator: ltc3589: make IRQ optional
In-Reply-To: <20160125135109.760ba5f0@ipc1.ka-ro>
References: <20160121102015.GI6588@sirena.org.uk>
 <20160121112611.34e17cb2@ipc1.ka-ro>
 <20160121111115.GJ6588@sirena.org.uk>
 <20160121123311.5346e40d@ipc1.ka-ro>
 <20160121162646.GK6588@sirena.org.uk>
 <20160122064145.36b7f2b4@ipc1.ka-ro>
 <20160122162610.GZ6588@sirena.org.uk>
 <20160125133731.72669115@ipc1.ka-ro>
 <20160125124123.GQ6588@sirena.org.uk>
 <20160125135109.760ba5f0@ipc1.ka-ro>
Message-ID: <20160125135220.GR6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 01:51:09PM +0100, Lothar Wa?mann wrote:
> On Mon, 25 Jan 2016 12:41:23 +0000 Mark Brown wrote:

> > The above, for example - make the interrupt optional.

> This will make it impossible to notify the system about
> overtemperature (and undervoltage).
> I implemented polling to be able to get at least overtemperature
> warnings.
> (Undervoltage cannot be handled sensibly without interrupt anyway)

I'm not convinced that justifies constantly polling, if the system
designers cared you'd hope they'd have wired it up to a working
interrupt.  People commonly don't, realistically thermal warnings are
usually set near the point where the silicon will be physically damaged
and typically by the time they fire the system is already experiencing
catastrophic problems at a system level.

The polling is at the very least a separate change, and making the
interrupt work would be a much better option.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/ba4fa286/attachment.sig>
