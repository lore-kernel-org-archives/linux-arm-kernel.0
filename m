From: broonie@kernel.org (Mark Brown)
Date: Thu, 10 Oct 2013 13:35:20 +0100
Subject: [RFC] ASoC: pcm: Trigger all commands on error
In-Reply-To: <20131010084040.GG19005@pengutronix.de>
References: <20131010084040.GG19005@pengutronix.de>
Message-ID: <20131010123520.GK21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 10:40:40AM +0200, Markus Pargmann wrote:

> For mxs-saif, we still have to store if the last START failed to handle
> the following STOP correctly which is not very different from handling
> double STOPs correctly. I don't have an idea how to fix RFCv1 without
> using some state as in RFCv2. Perhaps we should simply fix it in
> mxs-saif and other drivers then?

I think we have to - it seems like it's going to be more trouble than
it's worth to try to keep track of this in the core, there seems to be
a bit of an assumption that the triggers can just be called and for
things that aren't refcounting it's probably more robust to run the
trigger extra times rather than adding a state machine that we might get
wrong.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/1715d886/attachment.sig>
