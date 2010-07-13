From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jul 2010 10:33:46 +0100
Subject: [RFC,PATCH 0/2] Allow late mdesc detection
In-Reply-To: <1279011746.2521.394.camel@pororo.lan>
References: <1278903792.387175.713057245098.0.gpush@pororo>
	<alpine.LFD.2.00.1007112334390.10598@xanadu.home>
	<1278921935.9235.90.camel@pororo.lan>
	<alpine.LFD.2.00.1007120904240.10598@xanadu.home>
	<AANLkTikXejaVsFsudO3ABKzR80V6yCBHm7c6y32hurdt@mail.gmail.com>
	<20100713072848.GC19839@n2100.arm.linux.org.uk>
	<1279011746.2521.394.camel@pororo.lan>
Message-ID: <20100713093346.GC20590@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 05:02:26PM +0800, Jeremy Kerr wrote:
> It's been about 5 months since I started work on DT on ARM; I'm not sure
> who's been working on it previously, if anyone.

Grant promised me a DT implementation on a 'real platform' quite
some time ago.

> So far, most of the time has been preparation work - things like the clk
> infrastructure, and smaller bits like these addruart patches. We're (me,
> gcl and nico) also working carefully to specify the interfaces and
> standards correctly, for example getting the boot interface right, and
> standard formats for ARM device representation in the DT.

Things like a grand unification of the clk infrastructure, addruart,
and boot interface all seem to be relatively minor things compared
to determining whether platform support really benefits from DT,
which is whole point of my statement on wanting to see a real
implementation of it.

What I'm interested in its impact on the numerous board support files
that we currently have - some 348 of them at the present time.  For
example, currently these are used to provide small fragments of code
to drivers to support what are effectively board quirks.  What I'm
particularly interested in is how these quirks get attached to their
relevant drivers - and whether this becomes easier with DT or harder
with it.

If it makes this stuff simpler, then all well and good - it's a net
benefit.  If it makes this a lot more complicated - eg, because we
need to declare every bit of quirk code into some kind of table for
DT to pick up and bind in some manner to a driver - then moving to
DT will be a disaster for maintainability and readability, and we
lose type checking on these quirk functions.

It's this area, and related areas to it that I'm really interested
in, rather than these grand unification schemes which seem to be top
priority at the moment.

What really concerns me at the moment is that there's soo much work
being put into the peripheral DT issues without first answering the
question about whether DT on ARM is viable by providing a working
real complex platform implementation.
