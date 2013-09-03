From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Sep 2013 12:59:38 +0100
Subject: [PATCH 13/14] ASoC: kirkwood: add SPDIF output support
In-Reply-To: <20130903113832.GF6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <E1VFkaX-0003JN-DQ@rmk-PC.arm.linux.org.uk>
 <20130903111720.GF3084@sirena.org.uk>
 <20130903113832.GF6617@n2100.arm.linux.org.uk>
Message-ID: <20130903115938.GA1560@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 12:38:32PM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 03, 2013 at 12:17:20PM +0100, Mark Brown wrote:

> > This is still not a good approach to adding a new digital audio
> > interface since it does not create a DAI but instead adds it like an
> > analogue link (but hooked inside the CPU using the DPCM DAPM hooks).

> This is the way Liam's Haswell DPCM driver works.

Liam's driver also adds DAIs.

> > A new DAI should be being added for the S/PDIF interface, this should
> > fully utilise DPCM but an either/or approach would be OK as a stepping
> > stone.

> A new CPU DAI will be a front end DAI.  So what you're saying here is
> that your earlier statement where you clearly said "one front end and
> two back ends" was wrong.

I have not yet replied to the last e-mail you sent last night but it
appears from that that and from the above that you have front end and
back end confused.  A front end DAI should be associated with DMA, a
back end DAI should represent an external digital audio interface for
the SoC.  This means that the I2S and S/PDIF interfaces should both have
back end DAIs representing them and the DMA should be represented by a
front end.

> Sorry, I'm not playing your game anymore.  I'm not interested in trying
> to work with you anymore, because its totally impossible.  You're being
> as obstructive as you have been from the very start, and as demonstrated
> last night when you said "there is no mixer" in Liam's DPCM driver, you
> don't know what you're talking about half the time.  Or, you're
> intentionally making false statements.

I did not say that - I said:

| This is not correct, there is no mixer in the link between the back end
| and the CODEC.

The mixer in Haswell is in the DSP block which sits between the front
and back end DAIs, external devices like the CODEC are connected to the
back ends.  I fear that your confusion between front and back end may
have mislead you here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130903/1e873cb2/attachment.sig>
