From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Sep 2015 19:46:55 +0100
Subject: [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels capture and
 lrck-mode support
In-Reply-To: <5608F74C.3000104@rock-chips.com>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
 <20150923162433.GQ30445@sirena.org.uk>
 <5608F74C.3000104@rock-chips.com>
Message-ID: <20150930184655.GX15635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 04:16:12PM +0800, sugar wrote:
> ? 9/24/2015 00:24, Mark Brown ??:

> >My initial thought here is that the machine driver should be responsible
> >for setting this and then the DAI driver should check to see if
> >symmetric_rates are in use and configure itself appropriately.  Is there
> >a reason why this won't work here?

> It's for i2s ip configuration, in the most situation, there is no need
> to use this property, except one case:

> In order to save gpio pins for other function use, we may use single
> lrck(tx or rx) pin. of course, it depends on product design. when in i2s
> slave mode, we need to configure this to share lrck with tx/rx inside i2s
> logic.

> symmetric_rates flag works fine on rockchip platform, but it can't cover the
> above case.

> Do you have any suggestion about this or maybe there is no need to upstream
> this special part?

What makes you say that the symmetric_rates flag can't be used to cover
this case?  What you describe above is hte normal reason for needing to
enforce symmetric_rates.  The driver should be able to check if the flag
has been set just as well as the core is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150930/e8e96976/attachment.sig>
