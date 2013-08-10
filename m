From: broonie@kernel.org (Mark Brown)
Date: Sat, 10 Aug 2013 12:12:31 +0100
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu audio
 subsystem
In-Reply-To: <20130810093137.GV23006@n2100.arm.linux.org.uk>
References: <20130809094340.GO23006@n2100.arm.linux.org.uk>
 <5204CC04.4000401@gmail.com> <20130809113940.GY6427@sirena.org.uk>
 <20130809130932.GS23006@n2100.arm.linux.org.uk>
 <20130809180058.GM6427@sirena.org.uk>
 <20130809182516.GT23006@n2100.arm.linux.org.uk>
 <20130809194434.GP6427@sirena.org.uk>
 <20130809203847.GU23006@n2100.arm.linux.org.uk>
 <20130809234209.GQ6427@sirena.org.uk>
 <20130810093137.GV23006@n2100.arm.linux.org.uk>
Message-ID: <20130810111231.GR6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 10:31:37AM +0100, Russell King - ARM Linux wrote:

> Right, so what you're proposing is to come up with a DT description for
> the existing stuff, and then have to change (or at the very least augment)
> that description later when the DPCM stuff goes in.

> What should be done is to sort out DPCM, get that working and then sort out
> the DT side of it, so that everyone gets only one transition to DT, not a
> transition to a half-baked stop-gap DT and then have to go through another
> round of DT changes.  "Because we can" is not a good enough reason not to
> get this sorted properly.

Since we know what the hardware physically looks like we should be able
to write a DT binding which can be stable for both before and after the
DPCM transition.  The bindings would have to be truly awful to require a
rewrite here and as with all the DMA wrapper drivers if parts of DPCM
that don't reflect actual hardware are appearing in the DT we're doing
something wrong.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130810/e02a5778/attachment.sig>
