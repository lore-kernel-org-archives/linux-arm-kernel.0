From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Sep 2010 08:42:47 +0100
Subject: [RESEND PATCH] serial: samsung: fix device name
In-Reply-To: <20100924073453.GA3840@richter>
References: <20100923190212.18863.25678.stgit@darius-desktop>
	<4C9BE577.4050504@fluff.org>
	<AANLkTi=S8v19iT1DC=6Nh9BEgRvKzyzKTKoJmS0Bw1Fb@mail.gmail.com>
	<20100924073453.GA3840@richter>
Message-ID: <20100924074247.GB11371@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 24, 2010 at 09:34:53AM +0200, Simon Richter wrote:
> Hi,
> 
> On Fri, Sep 24, 2010 at 09:57:19AM +0300, Darius Augulis wrote:
> 
> > It does - now devices are named /dev/s3c2410_serial, and patch changes
> > its name to /dev/ttySAC
> 
> I wonder if it'd make sense to name them ttyS[0-9]. I've never
> understood why the platform standard fixed serial ports on any device
> should have a different name.

It's called namespace.  If platform serial ports are different, then
they have to have a separate namespace otherwise things like
console= end up having to have a separate namespace from the one
which the user sees in the filesystem.

Moreover, you introduce a bunch of special cases into the 8250 serial
driver - or you simply exclude the 8250 serial driver being used on a
platform.
