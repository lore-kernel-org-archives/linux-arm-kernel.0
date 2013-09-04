From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Sep 2013 20:33:53 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130902230011.GC6617@n2100.arm.linux.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
 <20130902141631.GV6617@n2100.arm.linux.org.uk>
 <20130902162729.GT3084@sirena.org.uk>
 <20130902165932.GZ6617@n2100.arm.linux.org.uk>
 <20130902204421.GW3084@sirena.org.uk>
 <20130902211830.GA6617@n2100.arm.linux.org.uk>
 <20130902223500.GA3084@sirena.org.uk>
 <20130902230011.GC6617@n2100.arm.linux.org.uk>
Message-ID: <20130904193353.GA3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 12:00:11AM +0100, Russell King - ARM Linux wrote:

> > You should have one back end DAI per physical DAI.

> What do you mean "physical DAI"?  Do you mean "CPU DAI" which would be a
> front end DAI?

The same question got asked and answered in another subthread but for
the record I'm speaking here about the back end DAIs - there should be
one for S/PDIF and one for I2S.  With DPCM there should also be a front
end DAI for the DMA.  I've cut a bunch of other discussion which was
duplicated in that subthread.

> > Unless there is a need to actually take some action you can, naturally,
> > provide stubs.  You should provide the minimal set of stubs required for
> > operation in your testing.

> That needs to go in the ASoC code though - I don't think I have access
> to the ALSA PCM which has been created for the backend DAI(s).  Remember,
> the backend DAIs are "owned" by the dummy DAI driver, not the CPU driver,
> so the CPU driver doesn't get to see any operations for that.

If you need to define operations for the dummy driver then modify the
dummy driver.  However as indicated in the other thread you should not
be using the dummy DAI driver for the CPU side back end.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130904/82e6cc89/attachment.sig>
