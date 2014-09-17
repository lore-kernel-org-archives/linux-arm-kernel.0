From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Sep 2014 09:44:36 -0700
Subject: [PATCH] BCM2835: Add I2S driver to device tree
In-Reply-To: <5418E985.5090708@wwwdotorg.org>
References: <1404895825-25668-1-git-send-email-broonie@kernel.org>
 <5418E985.5090708@wwwdotorg.org>
Message-ID: <20140917164436.GJ7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 07:53:09PM -0600, Stephen Warren wrote:
> On 07/09/2014 02:50 AM, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> > +		bcm2835_i2s: i2s at 7e203000 {
> > +			compatible = "brcm,bcm2835-i2s";
> > +			reg = <0x7e203000 0x20>,
> > +			      <0x7e101098 0x02>;
> > +
> > +			dmas = <&dma 2>,
> > +			       <&dma 3>;
> > +			dma-names = "tx", "rx";
> > +		};

> This node is already there (and even edited in this patch), so I dropped
> that hunk.

Right, not sure what went on with applying it upstream originally but it
looks like git rebase didn't figure out what was going on well - the
bcm2835_i2s is needed so we can reference the node.  I'll probably get
round to resending an incremental patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140917/f718a915/attachment.sig>
