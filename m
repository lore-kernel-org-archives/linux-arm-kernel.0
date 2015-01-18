From: broonie@kernel.org (Mark Brown)
Date: Sun, 18 Jan 2015 19:28:34 +0000
Subject: [PATCH v4 4/4] ARM: mvebu: Armada 385 GP: Add regulators to the
 SATA port
In-Reply-To: <54BBD13E.6030901@redhat.com>
References: <54B8D97B.3090908@free-electrons.com> <54B8E38A.6020709@redhat.com>
 <20150116123705.GM3043@sirena.org.uk> <54B9629C.9090800@redhat.com>
 <20150116202516.GL3856@sirena.org.uk> <54BA21F9.5050408@redhat.com>
 <20150117131404.GA6414@sirena.org.uk> <54BA7197.40301@redhat.com>
 <20150118123531.GA2809@sirena.org.uk> <54BBD13E.6030901@redhat.com>
Message-ID: <20150118192834.GE2809@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 18, 2015 at 04:29:02PM +0100, Hans de Goede wrote:
> On 18-01-15 13:35, Mark Brown wrote:

> >Right, but that's not what regulator-boot-on actually means (and I'm not
> >sure why you would think it would TBH)

> Well, the meaning of regulator-boot-on is not clearly defined really, to
> begin we need with fixing that, currently all the bindings file says is:

> - regulator-boot-on: bootloader/firmware enabled regulator

If that meant anything about what to do with the regulator at runtime it
would say so - it means exactly what it says.

> One could easily argue that the bootloader likely has a good reason to turn
> the regulator on, and that unless there is a specific driver which claims
> the regulator and thus knows what to do with it it is best left alone ...

That's an excessively big stretch; it doesn't reflect the reality that
the bootloader is often just leaving the settings it found on initial
power up alone nor the general quality of implementation concerns one
often sees with bootloaders.  A big use case for this feature is that
there is a fairly large class of systems where the bootloader can't be
relied on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150118/30390c74/attachment.sig>
