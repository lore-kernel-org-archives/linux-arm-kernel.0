From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 15:07:29 +0100
Subject: [PATCH RFC 00/13] Adding SPDIF support to kirkwood-i2s
In-Reply-To: <51FFA348.2010503@gmail.com>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com>
Message-ID: <20130805140729.GC9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 03:06:16PM +0200, Sebastian Hesselbarth wrote:

> looking at e.g. nvidia,tegra-audio-*.txt bindings, I guess you are
> proposing to have a new binding for every SoC/codec/board combination?
> Also, you should have seen "ASoC: fsl: Add S/PDIF machine driver", which
> is - again - proposing a new binding for fsl with spdif "codec".

> You really want me to go the same way or is there any "other board
> binding" I should follow?

Yes, go that way.  There is the simple-card driver which should be able
to grow to consume most of these things for simple stereo CODECs, having
the common clock API more widely available so we can create a hard
requirement that clocks be described using the clock API would help a
lot with that.

> That will be one machine driver for possibly all Marvell boards, not
> what e.g. tegra is doing with one machine driver for each board they
> can find. I understand that the exact wiring on each board may get
> complicated, but I don't see why a (well thought) binding should not
> be able to describe it?

The clocking arrangements for a smartphone are not that trivial and we
need to be able to cope with things like having more than two devices on
the bus.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/883b93f2/attachment.sig>
