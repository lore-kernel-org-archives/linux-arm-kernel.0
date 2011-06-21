From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 21 Jun 2011 12:42:14 -0600
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <4E00E3D2.6050602@firmworks.com>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
	<20110618161934.GH8195@ponder.secretlab.ca>
	<20110619073000.GA23171@S2100-06.ap.freescale.net>
	<20110621135558.GB9228@S2101-09.ap.freescale.net>
	<4E00E3D2.6050602@firmworks.com>
Message-ID: <BANLkTiny9xDwiUww9Ys+jQZ0SHdQATABUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 12:32 PM, Mitch Bradley <wmb@firmworks.com> wrote:
> I wonder if it makes sense to create a new device node "/linux-devices" to express a desired mapping from device nodes to /dev entries? ?The properties could be the names of device special files and the values the corresponding node phandles.

I've been trying /really/ hard to avoid doing something like that
because a lot of the time the desired Linux dev name is a
implementation detail, and a potentially unstable one at that.  If
Linux requires certain devices to have certain names because that is
how it hooks up clocks (which is the current situation on some
platforms), then I'd rather have Linux encode a lookup of the
preferred name, at least until the that particular implementation
detail goes away.

As for enumerating devices, I don't think this is a Linux-specific
thing.  In this case it is entirely reasonable to want to say /this
node/ is the second serial port, and /that node/ is the third, which
is information needed regardless of the client OS.

g.
