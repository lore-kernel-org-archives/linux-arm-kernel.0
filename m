From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Jul 2016 11:50:34 +0200
Subject: SPI: performance regression when using the common message
 queuing infrastructure
In-Reply-To: <577CD464.6050506@atmel.com>
References: <577CD464.6050506@atmel.com>
Message-ID: <20160707095034.GL6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 11:50:28AM +0200, Cyrille Pitchen wrote:

> So do you recommend us to keep our current generic implementation relying on
> the SPI framework workqueue or to go back to a custom implementation using
> tasklet?
> If we keep the current implementation, is there a way to improve the
> performances so we go back to something close to what he had before?

I'd suggest trying to implement whatever it is that your customm
implementation was doing in the core, having individual drivers trying
to open code the message pump is obviously not sensible.  If what you're
doing makes your controllers run faster it'll probably make everyone
else's run faster too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160707/e453244b/attachment.sig>
