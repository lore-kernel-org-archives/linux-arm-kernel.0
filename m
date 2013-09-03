From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Sep 2013 12:17:20 +0100
Subject: [PATCH 13/14] ASoC: kirkwood: add SPDIF output support
In-Reply-To: <E1VFkaX-0003JN-DQ@rmk-PC.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkaX-0003JN-DQ@rmk-PC.arm.linux.org.uk>
Message-ID: <20130903111720.GF3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 01:47:37PM +0100, Russell King wrote:
> Add support for SPDIF output.  This is enabled via a widget being
> connected to an output.  When this widget is not connected, SPDIF
> output will remain disabled.

This is still not a good approach to adding a new digital audio
interface since it does not create a DAI but instead adds it like an
analogue link (but hooked inside the CPU using the DPCM DAPM hooks).
While this may work right now but will not be robust as the framework is
developed and can cause problems in system integration.

A new DAI should be being added for the S/PDIF interface, this should
fully utilise DPCM but an either/or approach would be OK as a stepping
stone.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130903/887b131c/attachment.sig>
