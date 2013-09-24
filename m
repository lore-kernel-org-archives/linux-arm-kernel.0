From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Sep 2013 16:52:16 +0100
Subject: [PATCH] media: i2c: adv7343: fix the DT binding properties
In-Reply-To: <6800560.AEqRA3IBkp@avalon>
References: <1379073471-7244-1-git-send-email-prabhakar.csengg@gmail.com>
 <3002978.Cb6jL1xtkE@avalon> <5240B396.2010705@wwwdotorg.org>
 <6800560.AEqRA3IBkp@avalon>
Message-ID: <20130924155216.GG3226@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 11:44:57AM +0200, Laurent Pinchart wrote:
> On Monday 23 September 2013 15:33:10 Stephen Warren wrote:

> > So I think you want to make the supply properties mandatory in DT (since
> > some form of supply is mandatory in HW), yet make the driver support
> > broken DTs which don't have those properties, by error-checking the
> > return value from regulator_get(). You might want to put a note into DT
> > saying that a previous version of the binding didn't require those
> > supply properties, so they may be missing from older DTs.

> Are there such devices in the wild ?

>From v3.12 on the kernel will stub in a dummy supply if one isn't found
when using DT but I wouldn't mention that in the bindings since it's
very much fixing up broken DTs rather than a good idea.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130924/c9956124/attachment.sig>
